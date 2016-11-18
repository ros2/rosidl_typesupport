// generated from rosidl_typesupport_cpp/resource/msg__type_support.cpp.em
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

#include "@(spec.base_type.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.base_type.type))__struct.hpp"

@[for type_support in sorted(type_supports)]@
#include "@(type_support)/identifier.hpp"
#include "@(type_support)/message_type_support_decl.hpp"
@[end for]@

#include "rosidl_typesupport_cpp/identifier.hpp"
#include "rosidl_typesupport_cpp/message_type_support.hpp"
#include "rosidl_typesupport_cpp/type_support_map.h"
#include "rosidl_typesupport_cpp/visibility_control.h"

namespace @(spec.base_type.pkg_name)
{

namespace @(subfolder)
{

namespace rosidl_typesupport_cpp
{

typedef struct _type_support_ids_t
{
  const char * typesupport_identifier[@(len(type_supports))];
} _type_support_ids_t;

static const _type_support_ids_t _@(spec.base_type.type)_message_typesupport_ids = {
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

static const _type_support_data_t _@(spec.base_type.type)_message_typesupport_data = {
  {
@[for type_support in sorted(type_supports)]@
    ::@(type_support)::get_message_type_support_handle<
      @(spec.base_type.pkg_name)::@(subfolder)::@(spec.base_type.type)>(),
@[end for]@
  }
};

typedef struct _type_support_map_t
{
  const size_t size;
  const _type_support_ids_t * typesupport_identifier;
  const _type_support_data_t * data;
} _type_support_map_t;

static const _type_support_map_t _@(spec.base_type.type)_message_typesupport_map = {
  @(len(type_supports)),
  &_@(spec.base_type.type)_message_typesupport_ids,
  &_@(spec.base_type.type)_message_typesupport_data
};

static const rosidl_message_type_support_t @(spec.base_type.type)_message_type_support_handle = {
  ::rosidl_typesupport_cpp::typesupport_identifier,
  reinterpret_cast<const type_support_map_t *>(&_@(spec.base_type.type)_message_typesupport_map)
};

}  // namespace rosidl_typesupport_cpp

}  // namespace @(subfolder)

}  // namespace @(spec.base_type.pkg_name)


namespace rosidl_typesupport_cpp
{

template<>
const rosidl_message_type_support_t *
get_message_type_support_handle<@(spec.base_type.pkg_name)::@(subfolder)::@(spec.base_type.type)>()
{
  return &::@(spec.base_type.pkg_name)::@(subfolder)::rosidl_typesupport_cpp::@(spec.base_type.type)_message_type_support_handle;
}

}  // namespace rosidl_typesupport_cpp
