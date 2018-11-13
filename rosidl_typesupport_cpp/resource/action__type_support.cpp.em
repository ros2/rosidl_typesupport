// generated from rosidl_typesupport_cpp/resource/action__type_support.cpp.em
// generated code does not contain a copyright notice

@#######################################################################
@# EmPy template for generating <action>__type_support.cpp files
@#
@# Context:
@#  - spec (rosidl_parser.ActionSpecification)
@#    Parsed specification of the .action file
@#  - subfolder (string)
@#    The subfolder / subnamespace of the message, usually 'action'
@#  - get_header_filename_from_msg_name (function)
@#######################################################################
@

#include <action_msgs/msg/goal_status_array.hpp>
#include <action_msgs/srv/cancel_goal.hpp>

#include <@(spec.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.action_name))__feedback.hpp>
#include <@(spec.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.action_name))__goal.hpp>
#include <@(spec.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.action_name))__result.hpp>
#include <@(spec.pkg_name)/@(subfolder)/@(get_header_filename_from_msg_name(spec.action_name))__struct.hpp>
#include "rosidl_typesupport_cpp/visibility_control.h"

#include "rosidl_generator_c/action_type_support_struct.h"
#include "rosidl_typesupport_cpp/action_type_support.hpp"
#include "rosidl_typesupport_cpp/message_type_support.hpp"
#include "rosidl_typesupport_cpp/service_type_support.hpp"

namespace @(spec.pkg_name)
{

namespace @(subfolder)
{

namespace rosidl_typesupport_cpp
{

static rosidl_action_type_support_t @(spec.action_name)_action_type_support_handle = {
  NULL, NULL, NULL, NULL, NULL};

}  // namespace rosidl_typesupport_cpp

}  // namespace @(subfolder)

}  // namespace @(spec.pkg_name)

namespace rosidl_typesupport_cpp
{

template<>
ROSIDL_TYPESUPPORT_CPP_PUBLIC
const rosidl_action_type_support_t *
get_action_type_support_handle<@(spec.pkg_name)::@(subfolder)::@(spec.action_name)>()
{
  using ::@(spec.pkg_name)::@(subfolder)::rosidl_typesupport_cpp::@(spec.action_name)_action_type_support_handle;
  // Thread-safe by always writing the same values to the static struct
  @(spec.action_name)_action_type_support_handle.goal_service_type_support = get_service_type_support_handle<::@(spec.pkg_name)::@(subfolder)::@(spec.action_name)::GoalRequestService>();
  @(spec.action_name)_action_type_support_handle.result_service_type_support = get_service_type_support_handle<::@(spec.pkg_name)::@(subfolder)::@(spec.action_name)::GoalResultService>();
  @(spec.action_name)_action_type_support_handle.cancel_service_type_support = get_service_type_support_handle<::@(spec.pkg_name)::@(subfolder)::@(spec.action_name)::CancelGoalService>();
  @(spec.action_name)_action_type_support_handle.feedback_message_type_support = get_message_type_support_handle<::@(spec.pkg_name)::@(subfolder)::@(spec.action_name)::Feedback>();
  @(spec.action_name)_action_type_support_handle.status_message_type_support = get_message_type_support_handle<::@(spec.pkg_name)::@(subfolder)::@(spec.action_name)::GoalStatusMessage>();
  return &@(spec.action_name)_action_type_support_handle;
}

}  // namespace rosidl_typesupport_cpp
