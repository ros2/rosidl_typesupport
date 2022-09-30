@# Included from rosidl_typesupport_cpp/resource/idl__type_support.cpp.em
#include "rosidl_runtime_c/service_type_support_struct.h"
@{
TEMPLATE(
    'msg__type_support.cpp.em',
    package_name=package_name, interface_path=interface_path,
    message=service.request_message, include_directives=include_directives,
    type_supports=type_supports)
}@

@{
TEMPLATE(
    'msg__type_support.cpp.em',
    package_name=package_name, interface_path=interface_path,
    message=service.response_message, include_directives=include_directives,
    type_supports=type_supports)
}@

@{
TEMPLATE(
    'msg__type_support.cpp.em',
    package_name=package_name, interface_path=interface_path,
    message=service.event_message, include_directives=include_directives,
    type_supports=type_supports)
}@

@{
from rosidl_pycommon import convert_camel_case_to_lower_case_underscore
from rosidl_parser.definition import SERVICE_REQUEST_MESSAGE_SUFFIX
from rosidl_parser.definition import SERVICE_RESPONSE_MESSAGE_SUFFIX
from rosidl_parser.definition import SERVICE_EVENT_MESSAGE_SUFFIX
include_parts = [package_name] + list(interface_path.parents[0].parts) + [
    'detail', convert_camel_case_to_lower_case_underscore(interface_path.stem)]
include_base = '/'.join(include_parts)

header_files = [
    'cstddef',
    'rosidl_runtime_c/service_type_support_struct.h',
    include_base + '__struct.hpp',
]
if len(type_supports) != 1:
    header_files.append('rosidl_typesupport_cpp/identifier.hpp')
header_files.append('rosidl_typesupport_cpp/service_type_support.hpp')
if len(type_supports) != 1:
    header_files += [
        'rosidl_typesupport_c/type_support_map.h',
        'rosidl_typesupport_cpp/service_type_support_dispatch.hpp',
    ]
header_files.append('rosidl_typesupport_cpp/visibility_control.h')
if len(type_supports) != 1:
    header_files.append('rosidl_typesupport_interface/macros.h')
}@
@[for header_file in header_files]@
@[    if header_file in include_directives]@
// already included above
// @
@[    else]@
@{include_directives.add(header_file)}@
@[    end if]@
#include "@(header_file)"
@[end for]@
@
@[if len(type_supports) != 1]@
@[  for ns in service.namespaced_type.namespaces]@

namespace @(ns)
{
@[  end for]@

namespace rosidl_typesupport_cpp
{

typedef struct _@(service.namespaced_type.name)_type_support_ids_t
{
  const char * typesupport_identifier[@(len(type_supports))];
} _@(service.namespaced_type.name)_type_support_ids_t;

static const _@(service.namespaced_type.name)_type_support_ids_t _@(service.namespaced_type.name)_service_typesupport_ids = {
  {
@# TODO(dirk-thomas) use identifier symbol again
@[for type_support in sorted(type_supports)]@
    "@(type_support)",  // ::@(type_support)::typesupport_identifier,
@[end for]@
  }
};

typedef struct _@(service.namespaced_type.name)_type_support_symbol_names_t
{
  const char * symbol_name[@(len(type_supports))];
} _@(service.namespaced_type.name)_type_support_symbol_names_t;
#define STRINGIFY_(s) #s
#define STRINGIFY(s) STRINGIFY_(s)

static const _@(service.namespaced_type.name)_type_support_symbol_names_t _@(service.namespaced_type.name)_service_typesupport_symbol_names = {
  {
@[for type_support in sorted(type_supports)]@
    STRINGIFY(ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(@(type_support), @(', '.join([package_name] + list(interface_path.parents[0].parts))), @(service.namespaced_type.name))),
@[end for]@
  }
};

typedef struct _@(service.namespaced_type.name)_type_support_data_t
{
  void * data[@(len(type_supports))];
} _@(service.namespaced_type.name)_type_support_data_t;

static _@(service.namespaced_type.name)_type_support_data_t _@(service.namespaced_type.name)_service_typesupport_data = {
  {
@[for type_support in sorted(type_supports)]@
    0,  // will store the shared library later
@[end for]@
  }
};

static const type_support_map_t _@(service.namespaced_type.name)_service_typesupport_map = {
  @(len(type_supports)),
  "@(package_name)",
  &_@(service.namespaced_type.name)_service_typesupport_ids.typesupport_identifier[0],
  &_@(service.namespaced_type.name)_service_typesupport_symbol_names.symbol_name[0],
  &_@(service.namespaced_type.name)_service_typesupport_data.data[0],
};

@{event_type = '::'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]) + SERVICE_EVENT_MESSAGE_SUFFIX}

void *
rosidl_@('_'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]))_event_message_create(
  const rosidl_service_introspection_info_t * info,
  rcutils_allocator_t * allocator,
  const void * request_message,
  const void * response_message,
  bool enable_message_payload)
{
  if (nullptr == info) {
    throw std::invalid_argument("service introspection info struct cannot be null");
  }
  if (nullptr == allocator) {
    throw std::invalid_argument("allocator cannot be null");
  }
  auto * event_msg = static_cast<@event_type *>(allocator->allocate(sizeof(@event_type), allocator->state));
  if (nullptr == event_msg) {
    throw std::invalid_argument("allocation failed for service event message");
  }
  event_msg = new(event_msg) @(event_type)();

  event_msg->info.set__event_type(info->event_type);
  event_msg->info.set__sequence_number(info->sequence_number);
  event_msg->info.stamp.set__sec(info->stamp_sec);
  event_msg->info.stamp.set__nanosec(info->stamp_nanosec);

  std::array<uint8_t, 16> client_id;
  std::move(std::begin(info->client_id), std::end(info->client_id), client_id.begin());
  event_msg->info.client_id.set__uuid(client_id);

  // TODO(jacobperron): consider removing this argument and let users pass nullptr for both request and response messages
  if (!enable_message_payload) {
    return event_msg;
  }
  if (nullptr != request_message) {
    event_msg->request.push_back(*static_cast<const @('::'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]) + SERVICE_REQUEST_MESSAGE_SUFFIX) *> (request_message));
  }
  if (nullptr != response_message) {
    event_msg->response.push_back(*static_cast<const @('::'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]) + SERVICE_RESPONSE_MESSAGE_SUFFIX) *> (response_message));
  }

  return event_msg;
}

bool
rosidl_@('_'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]))_event_message_destroy(
  void* event_msg,
  rcutils_allocator_t * allocator)
{
  auto * event_msg_ = static_cast<@event_type *>(event_msg);
  event_msg_->~@(service.namespaced_type.name)_Event();
  allocator->deallocate(event_msg, allocator->state);
  return true;
}


static const rosidl_service_type_support_t @(service.namespaced_type.name)_service_type_support_handle = {
  .typesupport_identifier = ::rosidl_typesupport_cpp::typesupport_identifier,
  .data = reinterpret_cast<const type_support_map_t *>(&_@(service.namespaced_type.name)_service_typesupport_map),
  .func = ::rosidl_typesupport_cpp::get_service_typesupport_handle_function,
  .event_message_create_handle  = rosidl_@('_'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]))_event_message_create,
  .event_message_destroy_handle = rosidl_@('_'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]))_event_message_destroy,
  .event_typesupport = ::rosidl_typesupport_cpp::get_message_type_support_handle<@('::'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]))_Event>(),
};

}  // namespace rosidl_typesupport_cpp
@[  for ns in reversed(service.namespaced_type.namespaces)]@

}  // namespace @(ns)
@[  end for]@

@[else]@
@{
include_parts = [package_name] + list(interface_path.parents[0].parts) + [
    'detail', convert_camel_case_to_lower_case_underscore(interface_path.stem)]
include_base = '/'.join(include_parts)
header_file = include_base + '__' + list(type_supports)[0] + '.hpp'
}@
@[  if header_file in include_directives]@
// already included above
// @
@[  else]@
@{include_directives.add(header_file)}@
@[  end if]@
#include "@(header_file)"

@[end if]@
namespace rosidl_typesupport_cpp
{

template<>
ROSIDL_TYPESUPPORT_CPP_PUBLIC
const rosidl_service_type_support_t *
get_service_type_support_handle<@('::'.join([package_name] + list(interface_path.parents[0].parts)))::@(service.namespaced_type.name)>()
{
@[if len(type_supports) != 1]@
  return &::@('::'.join([package_name] + list(interface_path.parents[0].parts)))::rosidl_typesupport_cpp::@(service.namespaced_type.name)_service_type_support_handle;
@[else]@
  return ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(@(list(type_supports)[0]), @(', '.join([package_name] + list(interface_path.parents[0].parts))), @(service.namespaced_type.name))();
@[end if]@
}

}  // namespace rosidl_typesupport_cpp
