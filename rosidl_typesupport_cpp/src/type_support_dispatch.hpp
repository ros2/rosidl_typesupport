// Copyright 2016 Open Source Robotics Foundation, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#ifndef TYPE_SUPPORT_DISPATCH_HPP_
#define TYPE_SUPPORT_DISPATCH_HPP_

#include <cstddef>
#include <cstdio>
#include <cstring>
#include <stdexcept>

#include <string>

#include "rcutils/shared_library.h"
#include "rcpputils/find_library.hpp"
#include "rosidl_typesupport_cpp/type_support_map.h"

namespace rosidl_typesupport_cpp
{

extern const char * typesupport_identifier;

template<typename TypeSupport>
const TypeSupport *
get_typesupport_handle_function(
  const TypeSupport * handle, const char * identifier)
{
  if (strcmp(handle->typesupport_identifier, identifier) == 0) {
    return handle;
  }

  if (handle->typesupport_identifier == rosidl_typesupport_cpp::typesupport_identifier) {
    const type_support_map_t * map = \
      static_cast<const type_support_map_t *>(handle->data);
    for (size_t i = 0; i < map->size; ++i) {
      if (strcmp(map->typesupport_identifier[i], identifier) != 0) {
        continue;
      }
      rcutils_shared_library_t * lib = nullptr;
      rcutils_allocator_t allocator = rcutils_get_default_allocator();

      if (!map->data[i]) {
        char library_name[1024];
        snprintf(
          library_name, 1023, "%s__%s",
          map->package_name, identifier);
        std::string library_path = rcpputils::find_library_path(library_name);
        if (library_path.empty()) {
          throw std::runtime_error("Failed to find library '" + std::string(library_name) + "'");
        }

        lib = static_cast<rcutils_shared_library_t *>(allocator.allocate(
            sizeof(rcutils_shared_library_t), allocator.state));
        if (!lib) {
          throw std::bad_alloc();
        }

        *lib = rcutils_get_zero_initialized_shared_library();

        rcutils_ret_t ret = rcutils_load_shared_library(lib, library_path.c_str());
        if (ret != RCUTILS_RET_OK) {
          allocator.deallocate(lib, allocator.state);
          if (ret == RCUTILS_RET_INVALID_ARGUMENT) {
            throw std::runtime_error("Invaled arguments in rcutils_load_shared_library");
          } else if (ret == RCUTILS_RET_BAD_ALLOC) {
            throw std::bad_alloc();
          } else {
            throw std::runtime_error("Cannot open library " + library_path);
          }
        }
        map->data[i] = lib;
      }
      auto clib = static_cast<rcutils_shared_library_t *>(map->data[i]);
      void * sym = rcutils_get_symbol(clib, map->symbol_name[i]);
      if (!sym) {
        allocator.deallocate(lib, allocator.state);
        throw std::runtime_error(
                "Failed to find symbol '" + std::string(
                  map->symbol_name[i]) + "' in library");
      }

      typedef const TypeSupport * (* funcSignature)(void);
      funcSignature func = reinterpret_cast<funcSignature>(sym);
      const TypeSupport * ts = func();
      return ts;
    }
  }
  return nullptr;
}

}  // namespace rosidl_typesupport_cpp

#endif  // TYPE_SUPPORT_DISPATCH_HPP_
