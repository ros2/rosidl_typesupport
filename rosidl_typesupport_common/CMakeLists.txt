cmake_minimum_required(VERSION 3.5)

project(rosidl_typesupport_common)

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

find_package(ament_cmake REQUIRED)
# provides FindPoco.cmake and Poco on platforms without it
find_package(poco_vendor)
find_package(Poco COMPONENTS Foundation)
find_package(rosidl_generator_c REQUIRED)

link_directories(${Poco_LIBRARY_DIR})

ament_export_dependencies(rosidl_typesupport_interface)

ament_export_include_directories(include)

ament_python_install_package(${PROJECT_NAME})

set(common_name "rosidl_typesupport")
string(TOUPPER ${PROJECT_NAME} project_name_upper)

#ament_export_libraries(${PROJECT_NAME}_c ${PROJECT_NAME}_cpp)

set(lib_list ${PROJECT_NAME}_c ${PROJECT_NAME}_cpp)

ament_export_libraries(${lib_list})
if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()
endif()
ament_package(
    CONFIG_EXTRAS "${PROJECT_NAME}_c-extras.cmake.in"
                  "${PROJECT_NAME}_cpp-extras.cmake.in"
)

foreach(lib_name ${lib_list})
  string(TOUPPER ${lib_name} lib_name_upper)
  add_library(${lib_name} SHARED
    src/identifier.cpp
    src/message_type_support_dispatch.cpp
    src/service_type_support_dispatch.cpp
    src/type_support_dispatch.cpp)
  if(Poco_FOUND)
    target_compile_definitions(${lib_name}
      PRIVATE "${project_name_upper}_USE_POCO")
  endif()
  if(WIN32)
    target_compile_definitions(${lib_name}
      PRIVATE "${project_name_upper}_BUILDING_DLL")
  endif()
  target_include_directories(${lib_name}
    PUBLIC
    include ${Poco_INCLUDE_DIRS}
  )
  target_link_libraries(${lib_name} ${Poco_LIBRARIES})
  target_compile_definitions(${lib_name} PRIVATE "${lib_name_upper}")

  ament_target_dependencies(${lib_name} "rosidl_generator_c")

  install(
    PROGRAMS bin/${PROJECT_NAME}
    DESTINATION lib/${lib_name}
  )
  install(
    TARGETS ${lib_name}
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
  )
endforeach()

install(
  DIRECTORY cmake resource
  DESTINATION share/${PROJECT_NAME}
)
install(
  DIRECTORY include/
  DESTINATION include
)
