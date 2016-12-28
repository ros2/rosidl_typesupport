// generated from rosidl_typesupport_c/resource/msg__type_support.cpp.em
// generated code does not contain a copyright notice

@#######################################################################
@# EmPy template for generating <msg>__type_support.cpp files
@#
@# Context:
@#  - spec (rosidl_parser.MessageSpecification)
@#    Parsed specification of the .msg file
@#  - subfolder (string)
@#    The subfolder / subnamespace of the message
@#    Either 'msg' or 'srv'
@#  - type_supports (list of strings)
@#    The name of the type support packages
@#  - get_header_filename_from_msg_name (function)
@#######################################################################
@
#include <cstddef>

#include "rosidl_generator_c/message_type_support_struct.h"

#include "@(spec.base_type.pkg_name)/msg/rosidl_typesupport_c__visibility_control.h"
#include "@(spec.base_type.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.base_type.type))__struct.h"

#include "rosidl_typesupport_c/identifier.h"
#include "rosidl_typesupport_c/message_type_support_dispatch.h"
#include "rosidl_typesupport_c/type_support_map.h"
#include "rosidl_typesupport_c/visibility_control.h"
#include "rosidl_typesupport_interface/macros.h"

namespace @(spec.base_type.pkg_name)
{

namespace @(subfolder)
{

namespace rosidl_typesupport_c
{

typedef struct _type_support_ids_t
{
  const char * typesupport_identifier[@(len(type_supports))];
} _type_support_ids_t;

static const _type_support_ids_t _@(spec.base_type.type)_message_typesupport_ids = {
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

static const _type_support_symbol_names_t _@(spec.base_type.type)_message_typesupport_symbol_names = {
  {
@[for type_support in sorted(type_supports)]@
    STRINGIFY(ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(@(type_support), @(spec.base_type.pkg_name), @(subfolder), @(spec.base_type.type))),
@[end for]@
  }
};

typedef struct _type_support_data_t
{
  void * data[@(len(type_supports))];
} _type_support_data_t;

static _type_support_data_t _@(spec.base_type.type)_message_typesupport_data = {
  {
@[for type_support in sorted(type_supports)]@
    0,  // will store the shared library later
@[end for]@
  }
};

static const type_support_map_t _@(spec.base_type.type)_message_typesupport_map = {
  @(len(type_supports)),
  "@(spec.base_type.pkg_name)",
  &_@(spec.base_type.type)_message_typesupport_ids.typesupport_identifier[0],
  &_@(spec.base_type.type)_message_typesupport_symbol_names.symbol_name[0],
  &_@(spec.base_type.type)_message_typesupport_data.data[0],
};

static const rosidl_message_type_support_t @(spec.base_type.type)_message_type_support_handle = {
  rosidl_typesupport_c__typesupport_identifier,
  reinterpret_cast<const type_support_map_t *>(&_@(spec.base_type.type)_message_typesupport_map),
  rosidl_typesupport_c__get_message_typesupport_handle_function,
};

}  // namespace rosidl_typesupport_c

}  // namespace @(subfolder)

}  // namespace @(spec.base_type.pkg_name)


#ifdef __cplusplus
extern "C"
{
#endif

ROSIDL_TYPESUPPORT_C_EXPORT_@(spec.base_type.pkg_name)
const rosidl_message_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(rosidl_typesupport_c, @(spec.base_type.pkg_name), @(subfolder), @(spec.base_type.type))() {
  return &::@(spec.base_type.pkg_name)::@(subfolder)::rosidl_typesupport_c::@(spec.base_type.type)_message_type_support_handle;
}

#ifdef __cplusplus
}
#endif
