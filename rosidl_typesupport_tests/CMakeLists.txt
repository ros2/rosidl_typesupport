cmake_minimum_required(VERSION 3.8)
project(rosidl_typesupport_tests)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
  find_package(rosidl_cmake REQUIRED)
  find_package(ament_cmake_gtest REQUIRED)
  find_package(rosidl_generator_c REQUIRED)
  find_package(rosidl_generator_cpp REQUIRED)
  find_package(rosidl_runtime_c REQUIRED)
  find_package(rosidl_runtime_cpp REQUIRED)
  find_package(rosidl_typesupport_c REQUIRED)
  find_package(rosidl_typesupport_cpp REQUIRED)
  find_package(rosidl_typesupport_interface REQUIRED)
  find_package(test_interface_files REQUIRED)
  find_package(rcutils REQUIRED)
  find_package(rcpputils REQUIRED)

  rosidl_generate_interfaces(${PROJECT_NAME}
    ${test_interface_files_MSG_FILES}
    ${test_interface_files_SRV_FILES}
    ${test_interface_files_ACTION_FILES}
    SKIP_INSTALL
  )

  rosidl_get_typesupport_target(cpp_generator_target "${PROJECT_NAME}" "rosidl_generator_cpp")
  rosidl_get_typesupport_target(c_generator_target "${PROJECT_NAME}" "rosidl_generator_c")

  rosidl_get_typesupport_target(cpp_typesupport_target ${PROJECT_NAME} "rosidl_typesupport_cpp")
  rosidl_get_typesupport_target(c_typesupport_target ${PROJECT_NAME} "rosidl_typesupport_c")

  ament_add_gtest(test_service_typesupport_cpp
    test/rosidl_typesupport_cpp/test_service_typesupport.cpp
    APPEND_LIBRARY_DIRS "${CMAKE_CURRENT_BINARY_DIR}"
  )

  target_include_directories(test_service_typesupport_cpp PRIVATE test
    rosidl_typesupport_cpp)
  target_link_libraries(test_service_typesupport_cpp
    "${PROJECT_NAME}__rosidl_generator_c"
    "${PROJECT_NAME}__rosidl_generator_cpp"
    "${PROJECT_NAME}__rosidl_typesupport_c"
    "${PROJECT_NAME}__rosidl_typesupport_cpp"
    "${cpp_generator_target}"
    "${cpp_typesupport_target}"
    rosidl_runtime_cpp::rosidl_runtime_cpp
  )
    # ament_target_dependencies(test_service_typesupport_cpp
    #   "rosidl_runtime_cpp"
    #   "rosidl_typesupport_cpp")
    # add_dependencies(test_service_typesupport_cpp ${PROJECT_NAME}
    #   rosidl_typesupport_cpp)
    # target_link_libraries(test_service_typesupport_cpp
    #   rosidl_runtime_cpp::rosidl_runtime_cpp
    #   rosidl_typesupport_cpp::rosidl_typesupport_cpp
    # )
endif()



ament_package()
