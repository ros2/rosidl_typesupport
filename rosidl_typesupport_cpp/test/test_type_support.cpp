// Copyright 2020 Open Source Robotics Foundation, Inc.
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

// Provide a symbol so they can be checked with get_typesupport_handle_function()

#include "rosidl_typesupport_cpp/visibility_control.h"

// If ROSIDL_TYPESUPPORT_CPP_PUBLIC is used, it selects dllimport instead of dllexport, but the
// function still needs to be defined separately. Windows has gotten picky with its compiler
// warnings recently.
#if defined _WIN32 || defined __CYGWIN__
__declspec(dllexport) void test_type_support();
#else
void test_type_support();
#endif

void test_type_support() {}
