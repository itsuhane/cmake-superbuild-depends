# MIT License

# Copyright (c) 2019 jinyu li

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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

if(NOT COMMAND superbuild_system)
  function(superbuild_system system_name)
    include("${super-build-depends_SOURCE_DIR}/systems/${system_name}.cmake")
  endfunction()
endif()
