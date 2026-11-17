// Copyright 2026 Open Source Robotics Foundation, Inc.
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

#include "rosidl_typesupport_c/type_support_map.h"

#include "rcpputils/shared_library.hpp"

extern "C"
{
void
rosidl_typesupport_c__release_type_support_map(const type_support_map_t * map)
{
  if (nullptr == map || nullptr == map->data) {
    return;
  }
  for (size_t i = 0; i < map->size; ++i) {
    delete static_cast<rcpputils::SharedLibrary *>(map->data[i]);
    map->data[i] = nullptr;
  }
}
}  // extern "C"
