#foobar 演示子项目,你可以模范着来写
message("-> foobar module")

#扫描目录下的所有文件作为源文件
aux_source_directory(. DIR_SRCS)

#定义库名称
set(LIB_NAME foobar)
#库的bundle id,打包iOS ramework的时候需要用到
set(LIB_ID me.danwi.guazi.foobar)

#根据不同平台来定义生成方式
if (ANDROID_ARMV7A)
    #android armv7a架构
    #设置编译参数
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fvisibility=hidden")
    #声明一个动态/共享库
    add_library(${LIB_NAME} SHARED foobar.cpp)
    #链接 libxxx.a/.so/.dylib/.dll, libxxx2.a/.so/.dylib/.dll
    #target_link_libraries(${LIB_NAME} xxx xxx2)

elseif (IOS_ARMV7 OR IOS_ARM64)
    #iOS armv7和arm64架构
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++ -fvisibility=hidden")
    #声明一个动态/共享库
    add_library(${LIB_NAME} SHARED ${DIR_SRCS})
    #链接 libxxx.a/.so/.dylib/.dll, libxxx2.a/.so/.dylib/.dll
    #target_link_libraries(${LIB_NAME} xxx xxx2)
    #设置iOS打包为framework
    set_target_properties(${LIB_NAME} PROPERTIES
            FRAMEWORK TRUE
            FRAMEWORK_VERSION C
            MACOSX_FRAMEWORK_IDENTIFIER ${LIB_ID}
            LINK_FLAGS "-Wl,-exported_symbols_list,${CMAKE_CURRENT_SOURCE_DIR}/export.txt"
            )

elseif (WIN_64 OR WIN_32)
    #win32和win64构架
    #设置MT的打包方式
    set(CompilerFlags
            CMAKE_CXX_FLAGS
            CMAKE_CXX_FLAGS_DEBUG
            CMAKE_CXX_FLAGS_RELEASE
            CMAKE_C_FLAGS
            CMAKE_C_FLAGS_DEBUG
            CMAKE_C_FLAGS_RELEASE
            )
    foreach (CompilerFlag ${CompilerFlags})
        string(REPLACE "/MD" "/MT" ${CompilerFlag} "${${CompilerFlag}}")
    endforeach ()
    #声明一个动态/共享库
    add_library(${LIB_NAME} SHARED ${DIR_SRCS})
    #链接 libxxx.a/.so/.dylib/.dll, libxxx2.a/.so/.dylib/.dll
    #target_link_libraries(${LIB_NAME} xxx xxx2)

elseif (OSX_64 OR OSX_DEV)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++ -fvisibility=hidden")
    #声明一个动态/共享库
    add_library(${LIB_NAME} SHARED foobar.cpp)
    #链接 libxxx.a/.so/.dylib/.dll, libxxx2.a/.so/.dylib/.dll
    #target_link_libraries(${LIB_NAME} xxx xxx2)
    #依赖系统的framework,可以使用如下方式链接
    #add_framework(OpenCL ${LIB_NAME})
endif ()