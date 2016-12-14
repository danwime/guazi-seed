#iOS工具链加载
if (IOS_ARM64)
    message(STATUS "load ios arm64 tool chain")
    include(build/polly/ios-10-1-arm64.cmake)
elseif (IOS_ARMV7)
    message(STATUS "load ios armv7 tool chain")
    include(build/polly/ios-10-1-armv7.cmake)
endif ()