@# Included from rosidl_typesupport_c/resource/idl__type_support.c.em
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
    include_base + '__type_support.h',
]
if len(type_supports) != 1:
    header_files += [
        'rosidl_typesupport_c/identifier.h',
        'rosidl_typesupport_c/service_type_support_dispatch.h',
        'rosidl_typesupport_c/type_support_map.h',
    ]
header_files.append('rosidl_typesupport_interface/macros.h')
header_files.append('service_msgs/msg/service_event_info.h')
header_files.append('builtin_interfaces/msg/time.h')
header_files.append('unique_identifier_msgs/msg/uuid.h')
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

namespace rosidl_typesupport_c
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


@#TODO(ihasdapie): Import Postfixes
@{event_type = '__'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]) + SERVICE_EVENT_MESSAGE_SUFFIX}@
@{request_type = '__'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]) + SERVICE_REQUEST_MESSAGE_SUFFIX}@
@{response_type = '__'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]) + SERVICE_RESPONSE_MESSAGE_SUFFIX}@


void * rosidl_typesupport_c_@('__'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]))__event_message__create (
    const rosidl_service_introspection_info_t * info,
    rcutils_allocator_t * allocator,
    const void * request_message,
    const void * response_message,
    bool enable_message_payload)
{
  auto * event_msg = static_cast<@event_type *>(allocator->allocate(sizeof(@event_type), allocator->state));
  if (!@(event_type)__init(event_msg)) {
    allocator->deallocate(event_msg, allocator->state);
    return NULL;
  }

  event_msg->info.event_type = info->event_type;
  event_msg->info.sequence_number = info->sequence_number;
  event_msg->info.stamp.sec = info->stamp_sec;
  event_msg->info.stamp.nanosec = info->stamp_nanosec;
  for (size_t i = 0; i < 16; ++i) {
    event_msg->info.client_id.uuid[i] = info->client_id[i];
  }

  if (!enable_message_payload) {
      return event_msg;
  }

  if (request_message) {
    event_msg->response.capacity = 1;
    event_msg->response.size = 1;
    event_msg->response.data = static_cast<@response_type *>(allocator->allocate(sizeof(@response_type), allocator->state));
    if (! @(response_type)__copy((@response_type *) response_message, &event_msg->response.data[0])) {
      allocator->deallocate(event_msg, allocator->state);
      return NULL;
    }
  }
  if (response_message) {
    event_msg->request.capacity = 1;
    event_msg->request.size = 1;
    event_msg->request.data = static_cast<@request_type *>(allocator->allocate(sizeof(@request_type), allocator->state));
    if (! @(request_type)__copy((@request_type *) request_message, &event_msg->request.data[0])){
      allocator->deallocate(event_msg, allocator->state);
      return NULL;
    }
  }
  return event_msg;
}

bool rosidl_typesupport_c_@('__'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]))__event_message__destroy (
  void * event_msg,
  rcutils_allocator_t * allocator
)
{ 
  if (NULL == event_msg) {
    return false;
  }
  auto * _event_msg = static_cast<@event_type *>(event_msg);

  @(event_type)__fini((@event_type *) _event_msg);
  if (_event_msg->request.data){
    allocator->deallocate(_event_msg->request.data, allocator->state);
  }
  if (_event_msg->response.data){
    allocator->deallocate(_event_msg->response.data, allocator->state);
  }
  allocator->deallocate(_event_msg, allocator->state);
  return true;
}


static const rosidl_service_type_support_t @(service.namespaced_type.name)_service_type_support_handle = {
  .typesupport_identifier = rosidl_typesupport_c__typesupport_identifier,
  .data = reinterpret_cast<const type_support_map_t *>(&_@(service.namespaced_type.name)_service_typesupport_map),
  .func = rosidl_typesupport_c__get_service_typesupport_handle_function,
  .event_message_create_handle = rosidl_typesupport_c_@('__'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]))__event_message__create,
  .event_message_destroy_handle = rosidl_typesupport_c_@('__'.join([package_name, *interface_path.parents[0].parts, service.namespaced_type.name]))__event_message__destroy,
  .event_typesupport = &@(service.namespaced_type.name)_Event_message_type_support_handle
};



}  // namespace rosidl_typesupport_c
@[  for ns in reversed(service.namespaced_type.namespaces)]@

}  // namespace @(ns)
@[  end for]@

@[else]@
@{
header_file = include_base + '__' + list(type_supports)[0] + '.h'
}@
@[  if header_file in include_directives]@
// already included above
// @
@[  else]@
@{include_directives.add(header_file)}@
@[  end if]@
#include "@(header_file)"

@[end if]@
#ifdef __cplusplus
extern "C"
{
#endif

const rosidl_service_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(rosidl_typesupport_c, @(', '.join([package_name] + list(interface_path.parents[0].parts))), @(service.namespaced_type.name))() {
@[if len(type_supports) != 1]@
  return &::@('::'.join([package_name] + list(interface_path.parents[0].parts)))::rosidl_typesupport_c::@(service.namespaced_type.name)_service_type_support_handle;
@[else]@
  return ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(@(list(type_supports)[0]), @(', '.join([package_name] + list(interface_path.parents[0].parts))), @(service.namespaced_type.name))();
@[end if]@
}

#ifdef __cplusplus
}
#endif
