// Copyright 2022 Open Source Robotics Foundation, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <gtest/gtest.h>

#include "rosidl_typesupport_cpp/service_type_support.hpp"
#include "rosidl_typesupport_cpp/message_type_support.hpp"
#include "rcutils/allocator.h"

#include "rosidl_typesupport_cpp/service_type_support.hpp"

#include "rosidl_typesupport_tests/srv/basic_types.hpp"

#include "builtin_interfaces/msg/time.h"
#include "unique_identifier_msgs/msg/uuid.h"
#include "service_msgs/msg/service_event_info.h"
#include "rosidl_runtime_c/service_type_support_struct.h"

TEST(test_service_typesupport, event_message_create_and_destroy_invalid_arguments)
{
  rcutils_allocator_t allocator = rcutils_get_default_allocator();
  const rosidl_service_type_support_t * srv_ts =
    rosidl_typesupport_cpp::get_service_type_support_handle<rosidl_typesupport_tests::srv::BasicTypes>();

  rosidl_service_introspection_info_t valid_info;

  // null info
  {
    EXPECT_THROW(
      srv_ts->event_message_create_handle(nullptr, &allocator, nullptr, nullptr, true),
      std::invalid_argument);
  }
  // null allocator
  {
    EXPECT_THROW(
      srv_ts->event_message_create_handle(&valid_info, nullptr, nullptr, nullptr, true),
      std::invalid_argument);
  }
}

TEST(test_service_typesupport, basic_types_event_message_create)
{
  rcutils_allocator_t allocator = rcutils_get_default_allocator();
  const rosidl_service_type_support_t * srv_ts =
    rosidl_typesupport_cpp::get_service_type_support_handle<rosidl_typesupport_tests::srv::BasicTypes>();

  const rosidl_message_type_support_t * msg_ts =
    rosidl_typesupport_cpp::get_message_type_support_handle<rosidl_typesupport_tests::srv::BasicTypes_Event>();

  EXPECT_STREQ(srv_ts->typesupport_identifier, "rosidl_typesupport_cpp");
  EXPECT_STREQ(msg_ts->typesupport_identifier, "rosidl_typesupport_cpp");

  // typesupports are static so this comparison *should* be valid?
  EXPECT_EQ(srv_ts->event_typesupport, msg_ts);

  rosidl_service_introspection_info_t expected_info;
  expected_info.sequence_number = 2;
  expected_info.event_type = 2;
  expected_info.stamp_nanosec = 123;
  expected_info.stamp_sec = 123;
  auto uuid = std::array<uint8_t, 16>{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
  std::copy(uuid.begin(), uuid.end(), expected_info.client_id);

  auto expected_request = rosidl_typesupport_tests::srv::BasicTypes_Request();
  expected_request.int16_value = -1;
  expected_request.uint16_value = 123;
  auto expected_response = rosidl_typesupport_tests::srv::BasicTypes_Response();
  expected_response.bool_value = true;
  expected_response.string_value = "hello world";

  // null request and response arguments
  {
    auto * event = static_cast<rosidl_typesupport_tests::srv::BasicTypes_Event *>(
      srv_ts->event_message_create_handle(&expected_info, &allocator, nullptr, nullptr, true));
    ASSERT_NE(event, nullptr);
    EXPECT_EQ(event->info.sequence_number, expected_info.sequence_number);
    EXPECT_EQ(event->info.event_type, expected_info.event_type);
    EXPECT_EQ(event->info.stamp.nanosec, expected_info.stamp_nanosec);
    EXPECT_EQ(event->info.stamp.sec, expected_info.stamp_sec);
    for (int i = 0; i < 16; ++i) {
      EXPECT_EQ(event->info.client_id.uuid[i], expected_info.client_id[i]);
    }
    EXPECT_EQ(event->request.size(), 0U);
    EXPECT_EQ(event->response.size(), 0U);

    ASSERT_TRUE(srv_ts->event_message_destroy_handle(event, &allocator));

  }

  // request argument set, null response argument
  {
    auto * event = static_cast<rosidl_typesupport_tests::srv::BasicTypes_Event *>(
      srv_ts->event_message_create_handle(
        &expected_info,
        &allocator,
        static_cast<const void *>(&expected_request),
        nullptr,
        true));

    ASSERT_NE(event, nullptr);
    EXPECT_EQ(event->info.sequence_number, expected_info.sequence_number);
    EXPECT_EQ(event->info.event_type, expected_info.event_type);
    EXPECT_EQ(event->info.stamp.nanosec, expected_info.stamp_nanosec);
    EXPECT_EQ(event->info.stamp.sec, expected_info.stamp_sec);
    for (int i = 0; i < 16; ++i) {
      EXPECT_EQ(event->info.client_id.uuid[i], expected_info.client_id[i]);
    }
    ASSERT_EQ(event->request.size(), 1U);
    EXPECT_EQ(event->response.size(), 0U);
    EXPECT_EQ(event->request[0].int16_value, expected_request.int16_value);
    EXPECT_EQ(event->request[0].uint16_value, expected_request.uint16_value);
    ASSERT_TRUE(srv_ts->event_message_destroy_handle(event, &allocator));
  }

  // response argument set, null request argument
  {
    auto * event = static_cast<rosidl_typesupport_tests::srv::BasicTypes_Event *>(
      srv_ts->event_message_create_handle(
        &expected_info,
        &allocator,
        nullptr,
        static_cast<const void *>(&expected_response),
        true));

    ASSERT_NE(event, nullptr);
    EXPECT_EQ(event->info.sequence_number, expected_info.sequence_number);
    EXPECT_EQ(event->info.event_type, expected_info.event_type);
    EXPECT_EQ(event->info.stamp.nanosec, expected_info.stamp_nanosec);
    EXPECT_EQ(event->info.stamp.sec, expected_info.stamp_sec);
    for (int i = 0; i < 16; ++i) {
      EXPECT_EQ(event->info.client_id.uuid[i], expected_info.client_id[i]);
    }
    EXPECT_EQ(event->request.size(), 0U);
    ASSERT_EQ(event->response.size(), 1U);
    EXPECT_EQ(event->response[0].bool_value, expected_response.bool_value);
    EXPECT_EQ(event->response[0].string_value, expected_response.string_value);
    ASSERT_TRUE(srv_ts->event_message_destroy_handle(event, &allocator));
  }

  // both request and response arguments set
  {
    auto * event = static_cast<rosidl_typesupport_tests::srv::BasicTypes_Event *>(
      srv_ts->event_message_create_handle(
        &expected_info,
        &allocator,
        static_cast<const void *>(&expected_request),
        static_cast<const void *>(&expected_response),
        true));

    ASSERT_NE(event, nullptr);
    EXPECT_EQ(event->info.sequence_number, expected_info.sequence_number);
    EXPECT_EQ(event->info.event_type, expected_info.event_type);
    EXPECT_EQ(event->info.stamp.nanosec, expected_info.stamp_nanosec);
    EXPECT_EQ(event->info.stamp.sec, expected_info.stamp_sec);
    for (int i = 0; i < 16; ++i) {
      EXPECT_EQ(event->info.client_id.uuid[i], expected_info.client_id[i]);
    }
    ASSERT_EQ(event->request.size(), 1U);
    EXPECT_EQ(event->request[0].int16_value, expected_request.int16_value);
    EXPECT_EQ(event->request[0].uint16_value, expected_request.uint16_value);
    ASSERT_EQ(event->response.size(), 1U);
    EXPECT_EQ(event->response[0].bool_value, expected_response.bool_value);
    EXPECT_EQ(event->response[0].string_value, expected_response.string_value);
    ASSERT_TRUE(srv_ts->event_message_destroy_handle(event, &allocator));
  }
}

/* TODO(ihasdapie): As above but use c typesupports instead of cpp ones
 */
/* TEST(test_service_typesupport, basic_types_c_to_cpp)
{
} */
