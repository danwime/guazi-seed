#!/usr/bin/env bash

# 配置
# ios打包时需要用到的 development team id
# DEVELOPMENT_TEAM=FMWD2Q74R8
DEVELOPMENT_TEAM=FMWD2Q74R8

# 进入根目录
SCRIPT=`dirname $0`
cd $SCRIPT
ROOT=`pwd`
DIST=$ROOT/dist
TEMP=$DIST/build

IOS_ARM64=$TEMP/ios/arm64
IOS_ARMV7=$TEMP/ios/armv7
OSX64=$TEMP/osx/x86_64
ANDROID_ARMV7A=$TEMP/android/armv7a

clean(){
    # 清理缓存
    rm -rf $ROOT/_*
    rm -rf $DIST/*
    rm -rf $TEMP/*
}

build_ios(){
    # 构建iOS
    # ARM64
    echo "build ios arm64..."
    rm -rf $IOS_ARM64
    mkdir -p $IOS_ARM64
    cd $IOS_ARM64
    POLLY_IOS_DEVELOPMENT_TEAM=$DEVELOPMENT_TEAM cmake -Dpackage=ios -Darch=arm64 -GXcode --framework $ROOT
    cmake --build ./ --config Release

    # ARMV7
    echo "build ios arm64..."
    rm -rf $IOS_ARMV7
    mkdir -p $IOS_ARMV7
    cd $IOS_ARMV7
    POLLY_IOS_DEVELOPMENT_TEAM=$DEVELOPMENT_TEAM cmake -Dpackage=ios -Darch=armv7 -GXcode --framework $ROOT
    cmake --build ./ --config Release
}

# create_ios_framework libname bundle_id
create_ios_framework() {
    LIB_NAME=$1
    BUNDLE_ID=$2

    echo "create $LIB_NAME.framework[$BUNDLE_ID] for $LIB_NAME"

    cp $IOS_ARM64/$LIB_NAME/Release-iphoneos/$LIB_NAME.framework/$LIB_NAME $PACK/$LIB_NAME-64
    cp $IOS_ARMV7/$LIB_NAME/Release-iphoneos/$LIB_NAME.framework/$LIB_NAME $PACK/$LIB_NAME-7

    lipo -create $PACK/$LIB_NAME-64 $PACK/$LIB_NAME-7 -output $PACK/$LIB_NAME
    rm $PACK/$LIB_NAME-64 $PACK/$LIB_NAME-7

    FRAMEWORK=$PACK/$LIB_NAME.framework
    mkdir -p $FRAMEWORK
    cp $ROOT/build/ios_framework/Info.plist $FRAMEWORK/
    sed "s/LIB_FILE/$LIB_NAME/" $FRAMEWORK/Info.plist > $FRAMEWORK/tmp.plist;mv $FRAMEWORK/tmp.plist $FRAMEWORK/Info.plist
    sed "s/LIB_ID/$BUNDLE_ID/" $FRAMEWORK/Info.plist > $FRAMEWORK/tmp.plist;mv $FRAMEWORK/tmp.plist $FRAMEWORK/Info.plist
    cp $PACK/$LIB_NAME $FRAMEWORK/$LIB_NAME
    rm $PACK/$LIB_NAME
}

package_ios(){
    # 打包iOS
    echo "package ios..."
    PACK=$DIST/ios
    rm -rf $PACK
    mkdir -p $PACK

    #第一参数为子项目/库的名字的名字,也是生成的framework的名字,第二个参数为framework的bundle id
    create_ios_framework foobar me.danwi.guazi.foobar

    echo "package ios done"
}

build_osx() {
    # 构建OSX
    echo "build osx x86_64..."
    rm -rf $OSX64
    mkdir -p $OSX64
    cd $OSX64
    cmake -Dpackage=osx $ROOT
    cmake --build ./ --config Release
}

# create_osx_bundle bundle_name libname
create_osx_bundle() {
    BUNDLE_NAME=$1
    LIB_NAME=$2

    echo "create $BUNDLE_NAME.bundle for $LIB_NAME"

    BUNDLE=$PACK/$BUNDLE_NAME.bundle
    mkdir -p $BUNDLE
    cp -R $ROOT/build/osx_bundle/* $BUNDLE/
    sed "s/LIB_FILE/$BUNDLE_NAME/" $BUNDLE/Contents/Info.plist > $BUNDLE/Contents/tmp.plist;mv $BUNDLE/Contents/tmp.plist $BUNDLE/Contents/Info.plist
    cp $OSX64/$LIB_NAME/lib$LIB_NAME.dylib $BUNDLE/Contents/MacOS/$BUNDLE_NAME
}

package_osx() {
    # 打包OSX
    echo "package osx..."
    PACK=$DIST/osx
    rm -rf $PACK
    mkdir -p $PACK

    #第一参数为bundle的名字,第二个参数为子项目/库的名字
    create_osx_bundle GuaziFoobar foobar
    echo "package osx done"
}

build_android(){
    #构建android
    echo "build android armeabi-v7a..."
    rm -rf $ANDROID_ARMV7A
    mkdir -p $ANDROID_ARMV7A
    cd $ANDROID_ARMV7A
    cmake -Dpackage=android $ROOT
    cmake --build ./ --config Release
}

package_android(){
    # 打包android
    echo "package android..."
    PACK=$DIST/android
    rm -rf $PACK
    mkdir -p $PACK

    #把生成的so文件拷贝到对应的位置
    cp $ANDROID_ARMV7A/foobar/libfoobar.so $PACK/

    echo "package android done"
}

case $1 in
    clean)
        clean
        ;;
    osx)
        build_osx
        package_osx
        ;;
    ios)
        build_ios
        package_ios
        ;;
    android)
        build_android
        package_android
        ;;
    all)
        clean
        build_ios
        package_ios
        build_android
        package_android
        build_osx
        package_osx
        ;;
    *)
        echo "usage: ./make.sh ios|osx|android|all"
esac