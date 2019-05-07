if(NOT TARGET depends::glbinding)
  add_library(depends::glbinding INTERFACE IMPORTED GLOBAL)
  FetchContent_Declare(
    depends-glbinding
    GIT_REPOSITORY https://github.com/cginternals/glbinding.git
    GIT_TAG        v3.1.0
  )
  FetchContent_GetProperties(depends-glbinding)
  if(NOT depends-glbinding_POPULATED)
    message(STATUS "Fetching glbinding sources")
    FetchContent_Populate(depends-glbinding)
    message(STATUS "Fetching glbinding sources - done")
  endif()
  set(OPTION_BUILD_TOOLS OFF CACHE BOOL "" FORCE)
  set(OPTION_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
  add_subdirectory(${depends-glbinding_SOURCE_DIR} ${depends-glbinding_BINARY_DIR})
  find_package(glbinding CONFIG REQUIRED PATHS "${depends-glbinding_SOURCE_DIR}")
  target_link_libraries(depends::glbinding INTERFACE glbinding::glbinding glbinding::glbinding-aux)
endif()
