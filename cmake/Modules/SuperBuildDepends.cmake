include(FetchContent)

FetchContent_Declare(
  super-build-depends
  GIT_REPOSITORY https://github.com/itsuhane/cmake-superbuild-depends.git
  GIT_TAG        master
)
FetchContent_GetProperties(super-build-depends)
if(NOT super-build-depends_POPULATED)
  message(STATUS "Fetching SuperBuildDepends scripts")
  FetchContent_Populate(super-build-depends)
  message(STATUS "Fetching SuperBuildDepends scripts - done")
endif()

if(NOT COMMAND superbuild_option)
  function(superbuild_option option_name)
    include("${super-build-depends_SOURCE_DIR}/options/${option_name}.cmake")
  endfunction()
endif()

if(NOT COMMAND superbuild_depend)
  function(superbuild_depend depend_name)
    include("${super-build-depends_SOURCE_DIR}/depends/${depend_name}.cmake")
  endfunction()
endif()
