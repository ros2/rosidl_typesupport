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

#ifndef ROSIDL_TYPESUPPORT_CPP__SERVICE_TYPE_SUPPORT_DISPATCH_HPP_
#define ROSIDL_TYPESUPPORT_CPP__SERVICE_TYPE_SUPPORT_DISPATCH_HPP_

#include "rosidl_runtime_c/service_type_support_struct.h"
#include "rosidl_runtime_c/visibility_control.h"

#include "rosidl_typesupport_cpp/visibility_control.h"

namespace rosidl_typesupport_cpp
{

/// Get the service type support handle specific to this identifier.
/**
 * If the identifier is the same as this handle's typesupport_identifier, then the handle is
 * simply returned.  If the identifier is the hard-coded one for this typesupport, then
 * the handle is loaded from a shared library.  If the identifier is *not* the hard-coded
 * one for this typesupport, then a nullptr is returned and no error is set.  Finally,
 * if an error occurs while loading the handle from a shared library, then an error
 * is set and a nullptr is returned.
 *
 * The above contract allows this function to be used to probe for typesupports, and
 * also return errors in the case that something went wrong.  Callers should take care
 * to handle all cases above, and can disambiguate whether the probe failed or a
 * library loading error occurred by calling `rcutils_error_is_set` after this function.
 *
 * \param handle Handle to service type support
 * \param identifier The typesupport identifier to get the handle function for
 * \return The associated service typesupport handle if found, otherwise NULL
 */
ROSIDL_TYPESUPPORT_CPP_PUBLIC
const rosidl_service_type_support_t *
get_service_typesupport_handle_function(
  const rosidl_service_type_support_t * handle, const char * identifier) noexcept;

}  // namespace rosidl_typesupport_cpp

#endif  // ROSIDL_TYPESUPPORT_CPP__SERVICE_TYPE_SUPPORT_DISPATCH_HPP_
