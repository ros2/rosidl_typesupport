// generated from rosidl_typesupport_common/resource/srv__type_support.cpp.em
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

#include "@(spec.pkg_name)/msg/rosidl_typesupport_common__visibility_control.h"

@[if len(type_supports) != 1]@
#include "rosidl_typesupport_common/identifier.h"
#include "rosidl_typesupport_common/service_type_support_dispatch.h"
#include "rosidl_typesupport_common/type_support_map.h"
@[end if]@
#include "rosidl_typesupport_interface/macros.h"

@[if len(type_supports) != 1]@
namespace @(spec.pkg_name)
{

namespace srv
{

namespace rosidl_typesupport_common
{

typedef struct _type_support_ids_t
{
  const char * typesupport_identifier[@(len(type_supports))];
} _type_support_ids_t;

static const _type_support_ids_t _@(spec.srv_name)_service_typesupport_ids = {
  {
@# TODO(dirk-thomas) use identifier symbol again
@[for type_support in sorted(type_supports)]@
    "@(type_support)",  // ::@(type_support)::typesupport_identifier,
@[end for]@
  }
};

typedef struct _type_support_symbol_names_t
{
  const char * symbol_name[@(len(type_supports))];
} _type_support_symbol_names_t;

#define STRINGIFY_(s) #s
#define STRINGIFY(s) STRINGIFY_(s)

static const _type_support_symbol_names_t _@(spec.srv_name)_service_typesupport_symbol_names = {
  {
@[for type_support in sorted(type_supports)]@
    STRINGIFY(ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(@(type_support), @(spec.pkg_name), @(spec.srv_name))),
@[end for]@
  }
};

typedef struct _type_support_data_t
{
  void * data[@(len(type_supports))];
} _type_support_data_t;

static _type_support_data_t _@(spec.srv_name)_service_typesupport_data = {
  {
@[for type_support in sorted(type_supports)]@
    0,  // will store the shared library later
@[end for]@
  }
};

static const type_support_map_t _@(spec.srv_name)_service_typesupport_map = {
  @(len(type_supports)),
  "@(spec.pkg_name)",
  &_@(spec.srv_name)_service_typesupport_ids.typesupport_identifier[0],
  &_@(spec.srv_name)_service_typesupport_symbol_names.symbol_name[0],
  &_@(spec.srv_name)_service_typesupport_data.data[0],
};

static const rosidl_service_type_support_t @(spec.srv_name)_service_type_support_handle = {
  rosidl_typesupport_common__typesupport_identifier,
  reinterpret_cast<const type_support_map_t *>(&_@(spec.srv_name)_service_typesupport_map),
  rosidl_typesupport_common__get_service_typesupport_handle_function,
};

}  // namespace rosidl_typesupport_common

}  // namespace srv

}  // namespace @(spec.pkg_name)

@[else]@
#include "@(spec.pkg_name)/srv/@(get_header_filename_from_msg_name(spec.srv_name))__@(list(type_supports)[0]).h"

@[end if]@
#ifdef __cplusplus
extern "C"
{
#endif

ROSIDL_TYPESUPPORT_COMMON_EXPORT_@(spec.pkg_name)
const rosidl_service_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(rosidl_typesupport_common, @(spec.pkg_name), @(spec.srv_name))() {
@[if len(type_supports) != 1]@
  return &::@(spec.pkg_name)::srv::rosidl_typesupport_common::@(spec.srv_name)_service_type_support_handle;
@[else]@
  return ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(@(list(type_supports)[0]), @(spec.pkg_name), @(spec.srv_name))();
@[end if]@
}

#ifdef __cplusplus
}
#endif
