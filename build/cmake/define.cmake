#平台定义,在代码中就可以使用 #ifdef WIN 等预处理了
if (WIN_32 OR WIN_64)
    add_definitions(-DWIN)
elseif (ANDROID)
    add_definitions(-DANDROID)
elseif (IOS_ARMV7 OR IOS_ARM64)
    add_definitions(-DIOS)
elseif (OSX_64 OR OSX_DEV)
    add_definitions(-DOSX)
endif ()

#动态库导出头定义
if (WIN_32 OR WIN_64)
    add_definitions(-DEXPORT=__declspec\(dllexport\))
else ()
    add_definitions(-DEXPORT=__attribute__\(\(visibility\(\"default\"\)\)\))
endif ()