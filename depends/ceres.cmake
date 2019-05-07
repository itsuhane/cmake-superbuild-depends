if(NOT TARGET depends::ceres)
  add_library(depends::ceres INTERFACE IMPORTED GLOBAL)
  FetchContent_Declare(
    depends-ceres
    GIT_REPOSITORY https://github.com/ceres-solver/ceres-solver.git
    GIT_TAG        1.14.0
  )
  FetchContent_GetProperties(depends-ceres)
  if(NOT depends-ceres_POPULATED)
    message(STATUS "Fetching ceres-solver sources")
    FetchContent_Populate(depends-ceres)
    message(STATUS "Fetching ceres-solver sources - done")
  endif()
  # TODO: clean up parameters and avoid pollution.
  set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
  set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
  set(MINIGLOG ON CACHE BOOL "" FORCE)
  set(GFLAGS OFF CACHE BOOL "" FORCE)
  set(CXX11 ON CACHE BOOL "" FORCE)
  set(CXX11_THREADS ON CACHE BOOL "" FORCE)
  set(TBB OFF CACHE BOOL "" FORCE)
  set(OPENMP OFF CACHE BOOL "" FORCE)
  set(LAPACK ON CACHE BOOL "" FORCE)
  set(MINIGLOG_MAX_LOG_LEVEL 0 CACHE STRING "" FORCE)
  set(EIGEN_INCLUDE_DIR ${depends-eigen_SOURCE_DIR} CACHE PATH "" FORCE)
  add_subdirectory(${depends-ceres_SOURCE_DIR} ${depends-ceres_BINARY_DIR})
  target_include_directories(depends::ceres
    INTERFACE
      ${depends-ceres_BINARY_DIR}/config
      ${depends-ceres_SOURCE_DIR}/internal/ceres/miniglog
      ${depends-ceres_SOURCE_DIR}/include
  )
  target_link_libraries(depends::ceres INTERFACE ceres)
endif()
