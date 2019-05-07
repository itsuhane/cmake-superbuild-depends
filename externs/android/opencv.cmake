if(NOT TARGET depends::opencv)
  FetchContent_Declare(
    depends-opencv
    URL     https://github.com/opencv/opencv/releases/download/4.0.1/opencv-4.0.1-android-sdk.zip
    URL_MD5 88a2b08fbcc5874b219374a8b102154f
  )
  FetchContent_GetProperties(depends-opencv)
  if(NOT depends-opencv_POPULATED)
    message(STATUS "Fetching OpenCV SDK for Android")
    FetchContent_Populate(depends-opencv)
    message(STATUS "Fetching OpenCV SDK for Android - done")
  endif()
  find_package(OpenCV REQUIRED PATHS ${depends-opencv_SOURCE_DIR}/sdk/native/jni NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
  add_library(depends::opencv INTERFACE IMPORTED GLOBAL)
  target_link_libraries(depends::opencv INTERFACE ${OpenCV_LIBS})
endif()
