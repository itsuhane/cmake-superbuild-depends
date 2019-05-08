if(NOT TARGET depends::sensors-toolkit)
  FetchContent_Declare(
      depends-sensors-toolkit
      GIT_REPOSITORY https://github.com/itsuhane/sensors-toolkit.git
      GIT_TAG        3d3d26a
  )
  FetchContent_GetProperties(depends-sensors-toolkit)
  if(NOT depends-sensors-toolkit_POPULATED)
      message(STATUS "Fetching sensors-toolkit sources")
      FetchContent_Populate(depends-sensors-toolkit)
      message(STATUS "Fetching sensors-toolkit sources - done")
  endif()
  set(SENSORS_BUILD_PC_APP OFF CACHE INTERNAL "" FORCE)
  set(SENSORS_BUILD_IOS_APP OFF CACHE INTERNAL "" FORCE)
  add_subdirectory(${depends-sensors-toolkit_SOURCE_DIR} ${depends-sensors-toolkit_BINARY_DIR})
  add_library(depends::sensors-toolkit INTERFACE IMPORTED GLOBAL)
  target_link_libraries(depends::sensors-toolkit INTERFACE sensors)
  set(depends-sensors-toolkit-source-dir ${depends-sensors-toolkit_SOURCE_DIR} CACHE INTERNAL "" FORCE)
  set(depends-sensors-toolkit-binary-dir ${depends-sensors-toolkit_BINARY_DIR} CACHE INTERNAL "" FORCE)
  mark_as_advanced(depends-sensors-toolkit-source-dir)
  mark_as_advanced(depends-sensors-toolkit-binary-dir)
endif()
