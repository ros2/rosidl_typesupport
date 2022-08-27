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

// #include <rosidl_runtime_cpp/message_type_support_decl.hpp>
#include "rosidl_runtime_cpp/service_type_support_decl.hpp"
#include "rosidl_runtime_cpp/message_type_support_decl.hpp"
#include "rcutils/allocator.h"

#include "rosidl_typesupport_cpp/service_type_support.hpp"

#include "rosidl_typesupport_tests/srv/basic_types.hpp"

#include "builtin_interfaces/msg/time.h"
#include "unique_identifier_msgs/msg/uuid.h"
#include "service_msgs/msg/service_event_info.h"
#include "rosidl_runtime_c/service_type_support_struct.h"

TEST(test_service_typesupport, basic_types_cpp_to_cpp)
{
  rcutils_allocator_t allocator = rcutils_get_default_allocator();
  const rosidl_service_type_support_t * srv_ts = 
    rosidl_runtime_cpp::get_service_type_support_handle<rosidl_typesupport_tests::srv::BasicTypes>();

  const rosidl_message_type_support_t * msg_ts = 
    rosidl_runtime_cpp::get_message_type_support_handle<rosidl_typesupport_tests::srv::BasicTypes_Event>();


  EXPECT_EQ(srv_ts->typesupport_identifier, "rosidl_typesupport_cpp");
  EXPECT_EQ(msg_ts->typesupport_identifier, "rosidl_typesupport_cpp");

  // typesupports are static so this comparison *should* be valid?
  EXPECT_EQ(srv_ts->event_typesupport, msg_ts);

  rosidl_service_introspection_info_t info;

  info.sequence_number = 2;
  info.event_type = 2;
  info.stamp_nanosec = 123;
  info.stamp_sec = 123;
  auto uuid = std::array<uint8_t, 16>{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
  std::copy(uuid.begin(), uuid.end(), info.client_id);

  auto req = rosidl_typesupport_tests::srv::BasicTypes_Request();
  req.int16_value = -1;
  req.uint16_value = 123;
  auto resp = rosidl_typesupport_tests::srv::BasicTypes_Response();
  resp.bool_value = true;
  resp.string_value = "hello world";

  auto * event = static_cast<rosidl_typesupport_tests::srv::BasicTypes_Event *>(srv_ts->introspection_message_create_handle(
    &info, &allocator, nullptr, nullptr, true));
  EXPECT_EQ(event, nullptr);
  ASSERT_TRUE(srv_ts->introspection_message_destroy_handle(event, &allocator));

  event = static_cast<rosidl_typesupport_tests::srv::BasicTypes_Event *>(srv_ts->introspection_message_create_handle(
    &info, &allocator, static_cast<const void *>(&req), nullptr, true));

  EXPECT_EQ(event->info.sequence_number, info.sequence_number);
  EXPECT_EQ(event->info.event_type, info.event_type);
  EXPECT_EQ(event->info.stamp.nanosec, info.stamp_nanosec);
  EXPECT_EQ(event->info.stamp.sec, info.stamp_sec);
  for (int i = 0; i < 16; ++i) {
    EXPECT_EQ(event->info.client_id.uuid[i], info.client_id[i]);
  }
  EXPECT_EQ(event->request[0].int16_value, -1);
  EXPECT_EQ(event->request[0].uint16_value, 123);
  EXPECT_EQ(event->response.size(), 0U);
  ASSERT_TRUE(srv_ts->introspection_message_destroy_handle(event, &allocator));

  event = static_cast<rosidl_typesupport_tests::srv::BasicTypes_Event *>(srv_ts->introspection_message_create_handle(
      &info, &allocator, nullptr, static_cast<const void *>(&resp), true));

  EXPECT_EQ(event->info.sequence_number, info.sequence_number);
  EXPECT_EQ(event->info.event_type, info.event_type);
  EXPECT_EQ(event->info.stamp.nanosec, info.stamp_nanosec);
  EXPECT_EQ(event->info.stamp.sec, info.stamp_sec);
  for (int i = 0; i < 16; ++i) {
    EXPECT_EQ(event->info.client_id.uuid[i], info.client_id[i]);
  }
  EXPECT_EQ(event->request[0].bool_value, true);
  EXPECT_STREQ(event->request[0].string_value.data(), "hello world");
  ASSERT_TRUE(srv_ts->introspection_message_destroy_handle(event, &allocator));
}

/* TODO(ihasdapie): As above but use c typesupports instead of cpp ones
 */
/* TEST(test_service_typesupport, basic_types_c_to_cpp)
{
} */
