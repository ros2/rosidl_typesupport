cmake_minimum_required(VERSION 3.5)

project(rosidl_typesupport_c)

# Default to C11
if(NOT CMAKE_C_STANDARD)
  set(CMAKE_C_STANDARD 11)
endif()

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()
if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake_ros REQUIRED)
find_package(rcpputils REQUIRED)
find_package(rosidl_runtime_c REQUIRED)

ament_export_dependencies(rcpputils)
ament_export_dependencies(rosidl_runtime_c)
ament_export_dependencies(rosidl_typesupport_interface)

ament_export_include_directories(include)

ament_python_install_package(${PROJECT_NAME})

add_library(${PROJECT_NAME}
  src/identifier.c
  src/message_type_support_dispatch.cpp
  src/service_type_support_dispatch.cpp
  src/type_support_dispatch.cpp)
if(WIN32)
  target_compile_definitions(${PROJECT_NAME}
    PRIVATE "ROSIDL_TYPESUPPORT_C_BUILDING_DLL")
endif()
target_include_directories(${PROJECT_NAME} PUBLIC
  "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
  "$<INSTALL_INTERFACE:include>")

ament_target_dependencies(${PROJECT_NAME}
  "rcpputils"
  "rosidl_runtime_c"
)
ament_export_libraries(${PROJECT_NAME})
ament_export_targets(${PROJECT_NAME})

ament_index_register_resource("rosidl_runtime_packages")

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
endif()

if(BUILD_SHARED_LIBS)
  set(${PROJECT_NAME}_LIBRARY_TYPE "SHARED")
else()
  set(${PROJECT_NAME}_LIBRARY_TYPE "STATIC")
endif()

ament_package(
  CONFIG_EXTRAS "rosidl_typesupport_c-extras.cmake.in"
)

install(
  PROGRAMS bin/rosidl_typesupport_c
  DESTINATION lib/rosidl_typesupport_c
)
install(
  DIRECTORY cmake resource
  DESTINATION share/${PROJECT_NAME}
)
install(
  DIRECTORY include/
  DESTINATION include
)
install(
  TARGETS ${PROJECT_NAME} EXPORT ${PROJECT_NAME}
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)
