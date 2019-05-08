# cmake-superbuild-depends

CMake scripts for managing dependencies in a superbuild project.

## Goal

- **Not another package manager**.
- Build the entire dependency tree.
- Make dependency version managed.
- Make multiple use of a same dependency consistent.
  - Ensure build configurations are consistent.
  - Avoid build same dependency multiple times.
- Propagate dependency to downstream for managed project.

The only exception is the dependency of gigantic and cost-to-compile libraries like OpenCV and Qt.  
Huge libraries are provided as extern dependencies.

## Usage

```CMake
include(SuperBuildDepends)

superbuild_option(cpp17)
superbuild_option(modern-cpp) # expects cpp11 or cpp14 or cpp17
superbuild_depend(eigen)      # expects modern-cpp
superbuild_extern(opencv)     # use system provided or officially built package.

# options are in option:: namespace, depends and externs are in depends:: namespace.
target_link_dependencies(YourTarget
  PUBLIC
    options::modern-cpp
    depends::eigen
  PRIVATE
    depends::opencv
)
```

## Dependency Type & Propagation

There are three types of dependencies: `option`, `depend` and `extern`.  
For `depend` type, it can be either `managed` or `imported`.

`option` represents common compile options, for example `options::cpp17`.  
They can also be dependent on other options, for example `options::modern-cpp` is a pseudo-option, which is used to import `options::cpp11`, `options::cpp14` or `options::cpp17`.  
As we can see, `option` dependency are defined in `options::` namespace.

`depend` and `extern` dependencies are defined in `depends::` namespace.  
The difference is that `depend` dependencies will be built together with your own project, while `extern` dependencies use prebuilt assets provided.  
`depend` makes your project into a "superbuild" project.  
That's why this repository is named `cmake-superbuild-depends`.

`managed` and `imported` are internal concepts.  
`depend` can be `managed`. This means the dependency also uses `cmake-superbuild-depends`.  
For `managed` dependencies, they can automatically introduce their dependencies into the current project.  
Common dependencies are merged and compiled only once in the topmost project.  
For `imported` dependencies, they provide necessary wrapping and configurations for source code that are not using `cmake-superbuild-depends`.  
This is the common case, as most of the dependencies are already using their own build system.

Except `managed depend`, all other dependencies will **not** pull their dependencies into the current project.  
This means that when critical dependency is missing, you will be prompted with error message and will have to prepend the corresponding dependency to continue.  
In this way, the project owner will be notified about what will be introduced into the building process and will have a chance to review them.  
As for `managed depend`, it is intended for subprojects built for the topmost projects, so the owner should be aware of the dependencies it contains.

## Creating `managed` Project

A project can be `managed` if **all its dependencies are imported with** `cmake-superbuild-depends`.  
In this case, simply export your target in the `CMakeLists.txt`:

```CMake
export(TARGET MyTarget NAMESPACE MyNamespace:: FILE MyTargetConfig.cmake)
```

Then, create the corresponding dependency import script.

## Internal: Creating Import Script

```CMake
if(NOT TARGET depends::my-target)
  # check prerequisities
  # fetch source code
  # add source code into current project
  add_library(depends::my-target INTERFACE IMPORTED GLOBAL)
  # add configurations for depends::my-target
endif()
```
