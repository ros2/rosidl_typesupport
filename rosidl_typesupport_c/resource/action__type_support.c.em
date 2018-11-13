// generated from
// rosidl_typesupport_c/resource/action__type_support_c.em
// generated code does not contain a copyright notice

@#######################################################################
@# EmPy template for generating <action>__type_support.c files
@#
@# Context:
@#  - spec (rosidl_parser.ActionSpecification)
@#    Parsed specification of the .action file
@#  - subfolder (string)
@#    The subfolder / subnamespace of the message, usually 'action'
@#  - get_header_filename_from_msg_name (function)
@#######################################################################
@

#include <action_msgs/msg/goal_status_array.h>
#include <action_msgs/srv/cancel_goal.h>

#include <@(spec.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.action_name))__feedback.h>
#include <@(spec.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.action_name))__goal.h>
#include <@(spec.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.action_name))__result.h>


#include "@(spec.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.action_name))__type_support.h"


static rosidl_action_type_support_t _@(spec.pkg_name)__@(subfolder)__@(spec.action_name)__typesupport_c;

const rosidl_action_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__ACTION_SYMBOL_NAME(
  rosidl_typesupport_c, @(spec.pkg_name), @(subfolder), @(spec.action_name))()
{
  // Thread-safe by always writing the same values to the static struct
  _@(spec.pkg_name)__@(subfolder)__@(spec.action_name)__typesupport_c.goal_service_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(
    rosidl_typesupport_c, @(spec.pkg_name), @(subfolder), @(spec.action_name)_Goal)();
  _@(spec.pkg_name)__@(subfolder)__@(spec.action_name)__typesupport_c.result_service_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(
    rosidl_typesupport_c, @(spec.pkg_name), @(subfolder), @(spec.action_name)_Result)();
  _@(spec.pkg_name)__@(subfolder)__@(spec.action_name)__typesupport_c.cancel_service_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(
    rosidl_typesupport_c, action_msgs, srv, CancelGoal)();
  _@(spec.pkg_name)__@(subfolder)__@(spec.action_name)__typesupport_c.feedback_message_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(
    rosidl_typesupport_c, @(spec.pkg_name), @(subfolder), @(spec.action_name)_Feedback)();
  _@(spec.pkg_name)__@(subfolder)__@(spec.action_name)__typesupport_c.status_message_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(
    rosidl_typesupport_c, action_msgs, msg, GoalStatusArray)();

  return &_@(spec.pkg_name)__@(subfolder)__@(spec.action_name)__typesupport_c;
}
