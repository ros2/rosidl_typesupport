cmake_minimum_required(VERSION 3.20)
project(rosidl_typesupport_tests)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)

if(BUILD_TESTING)
  find_package(ament_cmake_gtest REQUIRED)
  find_package(ament_cmake_ros_core REQUIRED)
  find_package(ament_lint_auto REQUIRED)
  find_package(rcutils REQUIRED)
  find_package(rmw REQUIRED)
  find_package(rmw_implementation REQUIRED)
  find_package(rosidl_cmake REQUIRED)
  find_package(rosidl_generator_cpp REQUIRED)
  find_package(test_interface_files REQUIRED)

  ament_lint_auto_find_test_dependencies()

  rosidl_generate_interfaces(${PROJECT_NAME}
    ${test_interface_files_MSG_FILES}
    ${test_interface_files_SRV_FILES}
    ${test_interface_files_ACTION_FILES}
    SKIP_INSTALL
  )

  rosidl_get_typesupport_target(cpp_typesupport_target ${PROJECT_NAME} "rosidl_typesupport_cpp")
  rosidl_get_typesupport_target(c_typesupport_target ${PROJECT_NAME} "rosidl_typesupport_c")

  # With a single typesupport implementation (e.g. only the introspection one),
  # the wrapper typesupport is bypassed and the handles report the underlying
  # typesupport identifier instead of the wrapper one.
  get_used_typesupports(c_used_typesupports "rosidl_typesupport_c")
  get_used_typesupports(cpp_used_typesupports "rosidl_typesupport_cpp")

  ament_add_gtest(test_service_typesupport_cpp
    test/rosidl_typesupport_cpp/test_service_typesupport.cpp
  )
  list(LENGTH cpp_used_typesupports cpp_used_typesupports_count)
  if(cpp_used_typesupports_count EQUAL 1)
    target_compile_definitions(test_service_typesupport_cpp PRIVATE
      "EXPECTED_TYPESUPPORT_IDENTIFIER=\"${cpp_used_typesupports}\"")
  endif()
  target_link_libraries(test_service_typesupport_cpp
    "${cpp_typesupport_target}"
    rmw::rmw
    rmw_implementation::rmw_implementation
    ament_cmake_ros_core::ament_ros_defaults
  )

  ament_add_gtest(test_service_typesupport_c
    test/rosidl_typesupport_c/test_service_typesupport.cpp
  )
  list(LENGTH c_used_typesupports c_used_typesupports_count)
  if(c_used_typesupports_count EQUAL 1)
    target_compile_definitions(test_service_typesupport_c PRIVATE
      "EXPECTED_TYPESUPPORT_IDENTIFIER=\"${c_used_typesupports}\"")
  endif()
  target_link_libraries(test_service_typesupport_c
    "${c_typesupport_target}"
    rmw::rmw
    rmw_implementation::rmw_implementation
    ament_cmake_ros_core::ament_ros_defaults
  )
endif()

ament_package()
