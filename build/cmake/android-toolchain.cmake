#android编译工具链的加载
if (ANDROID_ARMV7A)
    message(STATUS "load android tool chain")
    include(build/polly/android-ndk-r10e-api-21-armeabi-v7a.cmake)
endif ()