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

#include <list>
#include <string>

#ifdef ROSIDL_TYPESUPPORT_CPP_USE_POCO
#include "Poco/SharedLibrary.h"
#endif

#include "rosidl_typesupport_cpp/type_support_map.h"

namespace rosidl_typesupport_cpp
{

// std::string find_library_path(const std::string & library_name);
using rosidl_typesupport_common::find_library_path;

// std::string get_env_var(const char * env_var);
using rosidl_typesupport_common::get_env_var;

// std::list<std::string> split(const std::string & value, const char delimiter)
using rosidl_typesupport_common::split;

// bool is_file_exist(const char * filename)
using rosidl_typesupport_common::is_file_exist;

// ?
extern const char * typesupport_identifier;

template<typename TypeSupport>
const TypeSupport *
get_typesupport_handle_function(
  const TypeSupport * handle, const char * identifier)
{
  return rosidl_typesupport_common::get_typesupport_handle_function(
    handle, identifier, rosidl_typesupport_cpp::typesupport_identifier);
}

}  // namespace rosidl_typesupport_cpp

#endif  // TYPE_SUPPORT_DISPATCH_HPP_
