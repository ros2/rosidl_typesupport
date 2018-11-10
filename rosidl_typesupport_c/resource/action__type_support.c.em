// generated from
// rosidl_typesupport_c/resource/action__type_support_c.em
// generated code does not contain a copyright notice

#include <action_msgs/msg/goal_info.h>
#include <action_msgs/msg/goal_status_array.h>
#include <action_msgs/srv/cancel_goal.h>
#include <rosidl_generator_c/action_type_support_struct.h>
#include <test_msgs/action/fibonacci__goal.h>
#include <test_msgs/action/fibonacci__result.h>
#include <test_msgs/action/fibonacci__feedback.h>

#include "test_msgs/action/fibonacci__type_support.h"


static rosidl_action_type_support_t _test_msgs__action__Fibonacci__typesupport_c;

const rosidl_action_type_support_t *
ROSIDL_TYPESUPPORT_INTERFACE__ACTION_SYMBOL_NAME(
  rosidl_typesupport_c, test_msgs, action, Fibonacci)()
{
  // Thread-safe by always writing the same values to the static struct
  _test_msgs__action__Fibonacci__typesupport_c.goal_service_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(
    rosidl_typesupport_c, test_msgs, action, Fibonacci_Goal)();
  _test_msgs__action__Fibonacci__typesupport_c.result_service_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(
    rosidl_typesupport_c, test_msgs, action, Fibonacci_Result)();
  _test_msgs__action__Fibonacci__typesupport_c.cancel_service_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__SERVICE_SYMBOL_NAME(
    rosidl_typesupport_c, action_msgs, srv, CancelGoal)();
  _test_msgs__action__Fibonacci__typesupport_c.feedback_message_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(
    rosidl_typesupport_c, test_msgs, action, Fibonacci_Feedback)();
  _test_msgs__action__Fibonacci__typesupport_c.status_message_type_support =
    ROSIDL_TYPESUPPORT_INTERFACE__MESSAGE_SYMBOL_NAME(
    rosidl_typesupport_c, action_msgs, msg, GoalStatusArray)();

  return &_test_msgs__action__Fibonacci__typesupport_c;
}
