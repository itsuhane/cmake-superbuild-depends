if(NOT TARGET depends::lightvis)
  FetchContent_Declare(
    depends-lightvis
    GIT_REPOSITORY https://github.com/itsuhane/lightvis.git
    GIT_TAG        master
  )
  FetchContent_GetProperties(depends-lightvis)
  if(NOT depends-lightvis_POPULATED)
    message(STATUS "Fetching lightvis sources")
    FetchContent_Populate(depends-lightvis)
    message(STATUS "Fetching lightvis sources - done")
  endif()
  add_subdirectory(${depends-lightvis_SOURCE_DIR} ${depends-lightvis_BINARY_DIR})
  add_library(depends::lightvis INTERFACE IMPORTED GLOBAL)
  target_link_libraries(depends::lightvis INTERFACE lightvis)
  set(depends-lightvis-source-dir ${depends-lightvis_SOURCE_DIR} CACHE INTERNAL "" FORCE)
  set(depends-lightvis-binary-dir ${depends-lightvis_BINARY_DIR} CACHE INTERNAL "" FORCE)
  mark_as_advanced(depends-lightvis-source-dir)
  mark_as_advanced(depends-lightvis-binary-dir)
endif()
