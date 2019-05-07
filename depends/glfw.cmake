if(NOT TARGET depends::glfw)
  add_library(depends::glfw INTERFACE IMPORTED GLOBAL)
  FetchContent_Declare(
    depends-glfw
    GIT_REPOSITORY https://github.com/glfw/glfw.git
    GIT_TAG        3.3
  )
  FetchContent_GetProperties(depends-glfw)
  if(NOT depends-glfw_POPULATED)
    message(STATUS "Fetching GLFW sources")
    FetchContent_Populate(depends-glfw)
    message(STATUS "Fetching GLFW sources - done")
  endif()
  set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
  set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
  set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
  add_subdirectory(${depends-glfw_SOURCE_DIR} ${depends-glfw_BINARY_DIR})
  target_link_libraries(depends::glfw INTERFACE glfw)
endif()
