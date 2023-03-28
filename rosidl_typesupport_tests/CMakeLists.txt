cmake_minimum_required(VERSION 3.8)
project(rosidl_typesupport_tests)

# Default to C++17
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 17)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)

if(BUILD_TESTING)
  find_package(ament_cmake_gtest REQUIRED)
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

  ament_add_gtest(test_service_typesupport_cpp
    test/rosidl_typesupport_cpp/test_service_typesupport.cpp
  )
  target_link_libraries(test_service_typesupport_cpp
    "${cpp_typesupport_target}"
    rmw::rmw
    rmw_implementation::rmw_implementation
  )

  ament_add_gtest(test_service_typesupport_c
    test/rosidl_typesupport_c/test_service_typesupport.cpp
  )
  target_link_libraries(test_service_typesupport_c
    "${c_typesupport_target}"
    rmw::rmw
    rmw_implementation::rmw_implementation
  )
endif()

ament_package()
