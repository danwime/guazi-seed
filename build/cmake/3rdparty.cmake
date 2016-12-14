#加载第三方的依赖 头文件/库
message(STATUS "load 3rdparty lib")

#加载android的原生依赖
if (ANDROID_ARMV7A)
    #ndk的路径必须设置环境变量
    if (EXISTS $ENV{ANDROID_NDK})
    else ()
        MESSAGE(FATAL_ERROR "ndk $ENV{ANDROID_NDK} is not exists")
    endif ()
    message(STATUS "load android sdk")
    set(ANDROID_INCLUDE $ENV{ANDROID_NDK}/platforms/android-21/arch-arm/usr/include)
    set(ANDROID_LIBS $ENV{ANDROID_NDK}/platforms/android-21/arch-arm/usr/lib)
    include_directories(${ANDROID_INCLUDE})
    link_directories(${ANDROID_LIBS})
endif ()


#opencv库的引入示例,假设在放置在3rdparty/opencv目录下
#针对不同的平台设置不同的库目录
#set(OPENCV_INCLUDE 3rdparty/opencv/include/)
#if (IOS_ARMV7 OR IOS_ARM64)
#    set(OPENCV_LIBS 3rdparty/opencv/libs/ios)
#elseif (OSX_64 OR OSX_DEV)
#    set(OPENCV_LIBS 3rdparty/opencv/libs/osx)
#elseif (ANDROID_ARMV7A)
#    set(OPENCV_LIBS 3rdparty/opencv/libs/android)
#elseif (WIN_64)
#    set(OPENCV_LIBS 3rdparty/opencv/libs/win/x64)
#elseif (WIN_32)
#    set(OPENCV_LIBS 3rdparty/opencv/libs/win/x86)
#endif ()
#添加到可链接目录中去
#include_directories(${OPENCV_INCLUDE})
#link_directories(${OPENCV_LIBS})
