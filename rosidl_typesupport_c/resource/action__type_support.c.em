@# Included from rosidl_typesupport_c/resource/idl__type_support.c.em
@{
from rosidl_cmake import convert_camel_case_to_lower_case_underscore
include_parts = [package_name] + list(interface_path.parents[0].parts) + \
    [convert_camel_case_to_lower_case_underscore(interface_path.stem)]
include_base = '/'.join(include_parts)

header_files = (
    'action_msgs/msg/goal_status_array.h',
    'action_msgs/srv/cancel_goal.h',
    include_base + '.h',
    include_base + '__type_support.h',
)
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

static rosidl_action_type_support_t _@('__'.join([package_name] + list(interface_path.parents[0].parts)))__@(interface_path.stem)__typesupport_c;

#ifdef __cplusplus
extern "C"
{
#endif

ROSIDL_TYPESUPPORT_C_EXPORT_@(package_name)
const rosidl_action_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__ACTION_SYMBOL_NAME(
  rosidl_typesupport_c, @(', '.join([package_name] + list(interface_path.parents[0].parts))), @(interface_path.stem))()
{
  // Thread-safe by always writing the same values to the static struct
  _@('__'.join([package_name] + list(interface_path.parents[0].parts)))__@(interface_path.stem)__typesupport_c.goal_service_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(
    rosidl_typesupport_c, @(', '.join([package_name] + list(interface_path.parents[0].parts))), @(interface_path.stem)_Action_Goal)();
  _@('__'.join([package_name] + list(interface_path.parents[0].parts)))__@(interface_path.stem)__typesupport_c.result_service_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(
    rosidl_typesupport_c, @(', '.join([package_name] + list(interface_path.parents[0].parts))), @(interface_path.stem)_Action_Result)();
  _@('__'.join([package_name] + list(interface_path.parents[0].parts)))__@(interface_path.stem)__typesupport_c.cancel_service_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(
    rosidl_typesupport_c, action_msgs, srv, CancelGoal)();
  _@('__'.join([package_name] + list(interface_path.parents[0].parts)))__@(interface_path.stem)__typesupport_c.feedback_message_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(
    rosidl_typesupport_c, @(', '.join([package_name] + list(interface_path.parents[0].parts))), @(interface_path.stem)_Action_Feedback)();
  _@('__'.join([package_name] + list(interface_path.parents[0].parts)))__@(interface_path.stem)__typesupport_c.status_message_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(
    rosidl_typesupport_c, action_msgs, msg, GoalStatusArray)();

  return &_@('__'.join([package_name] + list(interface_path.parents[0].parts)))__@(interface_path.stem)__typesupport_c;
}

#ifdef __cplusplus
}
#endif
