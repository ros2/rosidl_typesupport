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

#ifndef ROSIDL_TYPESUPPORT_CPP__MESSAGE_TYPE_SUPPORT_DISPATCH_HPP_
#define ROSIDL_TYPESUPPORT_CPP__MESSAGE_TYPE_SUPPORT_DISPATCH_HPP_

#include <cstdio>
#include <cstring>

#include "rosidl_generator_c/message_type_support_struct.h"
#include "rosidl_generator_c/visibility_control.h"

#include "rosidl_typesupport_cpp/identifier.hpp"
#include "rosidl_typesupport_cpp/type_support_map.h"

namespace rosidl_typesupport_cpp
{

ROSIDL_TYPESUPPORT_CPP_PUBLIC
const rosidl_message_type_support_t *
dispatch_message_type_support_handle(
  const char * identifier, const rosidl_message_type_support_t * handle)
{
  if (strcmp(handle->typesupport_identifier, identifier) == 0) {
    return handle;
  }
  if (handle->typesupport_identifier == rosidl_typesupport_cpp::typesupport_identifier) {
    const type_support_map_t * map = \
      static_cast<const type_support_map_t *>(handle->data);
    for (size_t i = 0; i < map->size; ++i) {
      if (map->typesupport_identifier[i] == identifier) {
        return static_cast<const rosidl_message_type_support_t *>(map->data[i]);
      }
    }
  }
  return nullptr;
}

}  // namespace rosidl_typesupport_cpp

#endif  // ROSIDL_TYPESUPPORT_CPP__MESSAGE_TYPE_SUPPORT_DISPATCH_HPP_
