if(NOT TARGET depends::lightvis)
  add_library(depends::lightvis INTERFACE IMPORTED GLOBAL)
  FetchContent_Declare(
    depends-lightvis
    GIT_REPOSITORY https://github.com/itsuhane/lightvis.git
    GIT_TAG        08ec828
  )
  FetchContent_GetProperties(depends-lightvis)
  if(NOT depends-lightvis_POPULATED)
    message(STATUS "Fetching lightvis sources")
    FetchContent_Populate(depends-lightvis)
    message(STATUS "Fetching lightvis sources - done")
  endif()
  add_subdirectory(${depends-lightvis_SOURCE_DIR} ${depends-lightvis_BINARY_DIR})
  target_link_libraries(depends::lightvis INTERFACE lightvis::lightvis)
endif()
