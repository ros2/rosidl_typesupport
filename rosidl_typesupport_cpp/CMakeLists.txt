cmake_minimum_required(VERSION 3.5)

project(rosidl_typesupport_cpp)

find_package(ament_cmake REQUIRED)

ament_index_get_resources(type_supports "rosidl_typesupport_cpp")
foreach(type_support ${type_supports})
  find_package(${type_support} REQUIRED)
  ament_export_dependencies(${type_support})
endforeach()

ament_export_include_directories(include)

ament_python_install_package(${PROJECT_NAME})

add_library(${PROJECT_NAME} SHARED src/identifier.cpp)
if(WIN32)
  target_compile_definitions(${PROJECT_NAME}
    PRIVATE "ROSIDL_TYPESUPPORT_CPP_BUILDING_DLL")
endif()
target_include_directories(${PROJECT_NAME}
  PUBLIC
  include
)
ament_export_libraries(${PROJECT_NAME})

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
endif()

ament_package(
  CONFIG_EXTRAS "rosidl_typesupport_cpp-extras.cmake.in"
)

install(
  PROGRAMS bin/rosidl_typesupport_cpp
  DESTINATION lib/rosidl_typesupport_cpp
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
  TARGETS ${PROJECT_NAME}
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)
