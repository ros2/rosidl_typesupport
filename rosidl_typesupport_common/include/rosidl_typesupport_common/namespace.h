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

#ifndef ROSIDL_TYPESUPPORT_COMMON__NAMESPACE_H_
#define ROSIDL_TYPESUPPORT_COMMON__NAMESPACE_H_

#if __cplusplus
namespace rosidl_typesupport_common {}
#endif

#define _ADD_C_NAMESPACE_(namespace, name)   namespace ## __ ## name
#define _ADD_CPP_NAMESPACE_(namespace, name) namespace :: name

#define NS_ROSIDL_TYPESUPPORT_C(name)   _ADD_C_NAMESPACE_  (rosidl_typesupport_common, name)
#define NS_ROSIDL_TYPESUPPORT_CPP(name) _ADD_CPP_NAMESPACE_(rosidl_typesupport_common, name)

#if defined (ROSIDL_TYPESUPPORT_COMMON_CPP)
  #define NS_ROSIDL_TYPESUPPORT(name) NS_ROSIDL_TYPESUPPORT_CPP(name)
  #define ROSIDL_TYPESUPPORT_STRING "rosidl_typesupport_cpp"
  #define NS_BEGIN namespace rosidl_typesupport_common {
  #define NS_END } // namespace rosidl_typesupport_common
#elif defined (ROSIDL_TYPESUPPORT_COMMON_C)
  #define NS_ROSIDL_TYPESUPPORT(name) NS_ROSIDL_TYPESUPPORT_C(name)
  #define ROSIDL_TYPESUPPORT_STRING "rosidl_typesupport_c"
  #if __cplusplus
    #define NS_BEGIN extern "C" {
    #define NS_END }  // extern "C"
  #else
    #define NS_BEGIN
    #define NS_END
  #endif
#endif

#endif  // ROSIDL_TYPESUPPORT_COMMON__NAMESPACE_H_
