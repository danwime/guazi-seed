cmake_minimum_required(VERSION 3.6)

include(build/cmake/macro.cmake)                #加载cmake宏定义
include(build/cmake/args.cmake)                 #解析cmake参数
include(build/cmake/android-toolchain.cmake)    #加载android工具链

#定义项目名
project("guazi")

include(build/cmake/define.cmake)               #加载#define定义文件
include(build/cmake/ios-toolchain.cmake)        #加载iOS工具链
include(build/cmake/3rdparty.cmake)             #第三方库加载

#包含子 [项目/库],这里包含的是一个测试库,你可以按照foobar的方式添加自己的库然后包含进来
add_subdirectory(foobar)

#开发环境下(OSX系统) 用来调试的可执行文件
if (OSX_DEV)

    #c版本
    #设置编译参数
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++")
    #声明一个可执行文件,指定源码
    add_executable(guazi-devc main.c)
    #指定这个可执行文件依赖的 子项目库 或 对应的第三方库
    target_link_libraries(guazi-devc foobar)
    #第三方 .a/.lib (静态库) .so/.dylib/.dll (动态库) 的包含方法,
    #如 libxxx.a 所在的目录在3rdparty.cmake已经引入,可以使用如下办法将 libxxx.a 连接到程序
    #target_link_libraries(guazi-devc foobar xxx)

    #OSX专有,如果你的项目依赖系统framework,下面一句话会链接 AVFoundation
    #add_framework(AVFoundation guazi-devc)

    #c++版本
    add_executable(guazi-devcpp main.cpp)
    target_link_libraries(guazi-devcpp foobar)

    #add_framework(AVFoundation guazi-devcpp)

endif ()