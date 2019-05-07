if(NOT TARGET depends::eigen)
  add_library(depends::eigen INTERFACE IMPORTED GLOBAL)
  if(TARGET options::moderncpp)
    target_link_libraries(depends::eigen INTERFACE options::moderncpp)
  else()
    message(FATAL_ERROR "depends::eigen expects options::moderncpp")
  endif()
  FetchContent_Declare(
    depends-eigen3
    GIT_REPOSITORY https://github.com/eigenteam/eigen-git-mirror.git
    GIT_TAG        3.3.7
  )
  FetchContent_GetProperties(depends-eigen3)
  if(NOT depends-eigen3_POPULATED)
    message(STATUS "Fetching Eigen3 sources")
    FetchContent_Populate(depends-eigen3)
    message(STATUS "Fetching Eigen3 sources - done")
  endif()
  target_include_directories(depends::eigen INTERFACE ${depends-eigen3_SOURCE_DIR})
endif()
