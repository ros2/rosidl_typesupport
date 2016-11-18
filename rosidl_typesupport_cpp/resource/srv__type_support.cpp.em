// generated from rosidl_typesupport_cpp/resource/srv__type_support.cpp.em
// generated code does not contain a copyright notice

@#######################################################################
@# EmPy template for generating <srv>__type_support.cpp files
@#
@# Context:
@#  - spec (rosidl_parser.ServiceSpecification)
@#    Parsed specification of the .srv file
@#  - type_supports (list of strings)
@#    The name of the type support packages
@#  - get_header_filename_from_msg_name (function)
@#######################################################################
@
#include <cstddef>

#include "rosidl_generator_c/service_type_support.h"

#include "@(spec.pkg_name)/srv/@(get_header_filename_from_msg_name(spec.srv_name))__struct.hpp"

@[for type_support in sorted(type_supports)]@
#include "@(type_support)/identifier.hpp"
#include "@(type_support)/service_type_support_decl.hpp"
@[end for]@

#include "rosidl_typesupport_cpp/identifier.hpp"
#include "rosidl_typesupport_cpp/service_type_support.hpp"
#include "rosidl_typesupport_cpp/type_support_map.h"
#include "rosidl_typesupport_cpp/visibility_control.h"

namespace @(spec.pkg_name)
{

namespace srv
{

namespace rosidl_typesupport_cpp
{

typedef struct _type_support_ids_t
{
  const char * typesupport_identifier[@(len(type_supports))];
} _type_support_ids_t;

static const _type_support_ids_t _@(spec.srv_name)_service_typesupport_ids = {
  {
@[for type_support in sorted(type_supports)]@
    ::@(type_support)::typesupport_identifier,
@[end for]@
  }
};

typedef struct _type_support_data_t
{
  const void * data[@(len(type_supports))];
} _type_support_data_t;

static const _type_support_data_t _@(spec.srv_name)_service_typesupport_data = {
  {
@[for type_support in sorted(type_supports)]@
    ::@(type_support)::get_service_type_support_handle<
      @(spec.pkg_name)::srv::@(spec.srv_name)>(),
@[end for]@
  }
};

typedef struct _type_support_map_t
{
  const size_t size;
  const _type_support_ids_t * typesupport_identifier;
  const _type_support_data_t * data;
} _type_support_map_t;

static const _type_support_map_t _@(spec.srv_name)_service_typesupport_map = {
  @(len(type_supports)),
  &_@(spec.srv_name)_service_typesupport_ids,
  &_@(spec.srv_name)_service_typesupport_data
};

static const rosidl_service_type_support_t @(spec.srv_name)_service_type_support_handle = {
  ::rosidl_typesupport_cpp::typesupport_identifier,
  reinterpret_cast<const type_support_map_t *>(&_@(spec.srv_name)_service_typesupport_map)
};

}  // namespace rosidl_typesupport_cpp

}  // namespace srv

}  // namespace @(spec.pkg_name)


namespace rosidl_typesupport_cpp
{

template<>
const rosidl_service_type_support_t *
get_service_type_support_handle<@(spec.pkg_name)::srv::@(spec.srv_name)>()
{
  return &::@(spec.pkg_name)::srv::rosidl_typesupport_cpp::@(spec.srv_name)_service_type_support_handle;
}

}  // namespace rosidl_typesupport_cpp
