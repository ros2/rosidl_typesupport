# `rosidl_typesupport_cpp` features

`rosidl_typesupport_cpp` provides a Python generator [executable](bin/rosidl_typesupport_cpp) based on Empy to create rosidl C++ source files.

The templates utilized by this generator executable are located in resource and generate source files for:
* [Messages](resource/msg__type_support.cpp.em)
* [Services](resource/srv__type_support.cpp.em)
* [Actions](resource/action__type_support.cpp.em)

`rosidl_typesupport_cpp` defines a typesupport identifier, which is declared in [identifier.hpp](include/rosidl_typesupport_c/identifier.hpp).

`rosidl_typesupport_cpp` provides the following functionality for incorporation into generated typesupport source files.

* [message_type_support_dispatch.hpp](include/rosidl_typesupport_c/message_type_support_dispatch.hpp): Look up message type support handle functions from available libraries.
* [service_type_support_dispatch.hpp](include/rosidl_typesupport_c/service_type_support_dispatch.hpp): Look up service type support handle functions from available libraries.
* [type_support_map_t.hpp](include/rosidl_typesupport_c/type_support_map_t.hpp): This defines the lookup of C++ typesupport handlers.
