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
set(PROJECT_TARGETS ${PROJECT_NAME})

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()

  add_library(rosidl_typesupport_c__test_type_support1
    test/test_type_support.c)
  target_include_directories(rosidl_typesupport_c__test_type_support1 PRIVATE include)
  ament_export_libraries(rosidl_typesupport_c__test_type_support1)

  # This same library is added a second type with a new name for additional tests
  add_library(rosidl_typesupport_c__test_type_support2
    test/test_type_support.c)
  target_include_directories(rosidl_typesupport_c__test_type_support2 PRIVATE include)
  ament_export_libraries(rosidl_typesupport_c__test_type_support2)
  set(PROJECT_TARGETS ${PROJECT_TARGETS} rosidl_typesupport_c__test_type_support1 rosidl_typesupport_c__test_type_support2)

  ament_add_gtest(test_message_type_support test/test_message_type_support_dispatch.cpp)
  if(TARGET test_message_type_support)
    target_link_libraries(test_message_type_support
      ${PROJECT_NAME}
    )
  endif()

  ament_add_gtest(test_service_type_support test/test_service_type_support_dispatch.cpp)
  if(TARGET test_service_type_support)
    target_link_libraries(test_service_type_support
      ${PROJECT_NAME}
    )
  endif()

  # Test type_support_dispatch throws runtime error when trying to load this "library"
  set(INVALID_LIBRARY_FILE "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_SHARED_LIBRARY_PREFIX}rosidl_typesupport_c__test_type_support3${CMAKE_SHARED_LIBRARY_SUFFIX}")
  file(GENERATE
    OUTPUT
    ${INVALID_LIBRARY_FILE}
    CONTENT "I'm not a shared library, why would you treat me like one?")
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
  TARGETS ${PROJECT_TARGETS} EXPORT ${PROJECT_NAME}
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)

if(BUILD_TESTING)
  if(WIN32)
  install(FILES ${INVALID_LIBRARY_FILE}
          DESTINATION bin)
  else()
  install(FILES ${INVALID_LIBRARY_FILE}
          DESTINATION lib)
  endif()
endif()
