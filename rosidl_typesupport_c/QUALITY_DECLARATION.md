This document is a declaration of software quality for the `rosidl_typesupport_c` package, based on the guidelines in [REP-2004](https://www.ros.org/reps/rep-2004.html).

# `rosidl_typesupport_c` Quality Declaration

The package `rosidl_typesupport_c` claims to be in the **Quality Level 4** category.

Below are the rationales, notes, and caveats for this claim, organized by each requirement listed in the [Package Requirements for Quality Level 4 in REP-2004](https://www.ros.org/reps/rep-2004.html).

## Version Policy

### Version Scheme

`rosidl_typesupport_c` uses `semver` according to the recommendation for ROS Core packages in the [ROS 2 Developer Guide](https://index.ros.org/doc/ros2/Contributing/Developer-Guide/#versioning).
However, it is not yet at a stable version, i.e. `>= 1.0.0`.

### API Stability Within a Released ROS Distribution

`rosidl_typesupport_c` will not break public API within a released ROS distribution, i.e. no major releases once the ROS distribution is released.

### ABI Stability Within a Released ROS Distribution

`rosidl_typesupport_c` contains C code and therefore must be concerned with ABI stability, and will maintain ABI stability within a ROS distribution.

### Public API Declaration

All symbols in the installed headers are considered part of the public API.

All installed headers are in the `include` directory of the package, headers in any other folders are not installed and considered private.

## Change Control Process

`rosidl_typesupport_c` follows the recommended guidelines for ROS Core packages in the [ROS 2 Developer Guide](https://index.ros.org/doc/ros2/Contributing/Developer-Guide/#package-requirements).

This includes:

- all changes occur through a pull request
- all pull request have at least 1 peer review
- all pull request must pass CI on all [tier 1 platforms](https://www.ros.org/reps/rep-2000.html#support-tiers)
- all pull request must resolve related documentation changes before merging

## Documentation

### Feature Documentation

`rosidl_typesupport_c` does not have any feature documentation and it will need to be added for higher quality levels.

### Public API Documentation

`rosidl_typesupport_c` does not currently have public API documentation.

### License

The license for `rosidl_typesupport_c` is Apache 2.0, and a summary is in each source file, the type is declared in the `package.xml` manifest file, and a full copy of the license is in the `LICENSE` file.

There is an automated test which runs a linter that ensures each file has a license statement.

### Copyright Statements

The copyright holders each provide a statement of copyright in each source code file in `rosidl_typesupport_c`.

There is an automated test which runs a linter that ensures each file has at least one copyright statement.

## Testing

### Feature Testing

There are currently no public features undergoing tests.

### Public API Testing

There are currently no tests for the public API.

### Coverage

`rosidl_typesupport_c` does not currently track test coverage.

### Performance

`rosidl_typesupport_c` does not currently have performance tests.

### Linters and Static Analysis

`rosidl_typesupport_c` uses and passes all the standard linters and static analysis tools for a C++ package as described in the [ROS 2 Developer Guide](https://index.ros.org/doc/ros2/Contributing/Developer-Guide/#linters).

## Dependencies

`rosidl_typesupport_c` has the following ROS dependencies:
* `rcpputils`
* `rosidl_runtime_c`
* `rosidl_typesupport_connext_c`
* `rosidl_typesupport_interface`
* `rosidl_typesupport_introspection_c`

It has "buildtool" dependencies, which do not affect the resulting quality of the package, because they do not contribute to the public library API.
It also has several test dependencies, which do not affect the resulting quality of the package, because they are only used to build and run the test code.

## Platform Support

`rosidl_typesupport_c` supports all of the tier 1 platforms as described in [REP-2000](https://www.ros.org/reps/rep-2000.html#support-tiers), and tests each change against all of them.
