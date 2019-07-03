if(NOT TARGET depends::popl)
  if(NOT TARGET options::modern-cpp)
    message(FATAL_ERROR "depends::popl expects options::modern-cpp")
  endif()
  FetchContent_Declare(
    depends-popl
    GIT_REPOSITORY https://github.com/badaix/popl.git
    GIT_TAG        v1.2.0
  )
  FetchContent_GetProperties(depends-popl)
  if(NOT depends-popl_POPULATED)
    message(STATUS "Fetching popl sources")
    FetchContent_Populate(depends-popl)
    message(STATUS "Fetching popl sources - done")
  endif()
  add_library(depends::popl INTERFACE IMPORTED GLOBAL)
  target_link_libraries(depends::popl INTERFACE options::modern-cpp)
  target_include_directories(depends::popl INTERFACE ${depends-popl_SOURCE_DIR}/include)
  set(depends-popl-source-dir ${depends-popl_SOURCE_DIR} CACHE INTERNAL "" FORCE)
  mark_as_advanced(depends-popl-source-dir)
endif()
