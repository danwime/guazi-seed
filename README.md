# 跨平台原生打包 种子项目
项目主要用来做其他项目的初始项目,免得以后再建立各种配置文件了...  
为什么要项目名字要叫瓜子(guazi),仅仅是因为想名字的时候恰好在嗑瓜子  

-----
#### 特性&TODO:  
- [x] 使用cmake作为构建系统
- [x] 支持iOS, armv7+arm64
- [x] 支持android armv7a
- [x] 支持windows 32位+64位
- [x] 支持OSX 64
- [x] 在OSX系统中可调试(感动 T_T)
- [x] 一键打包,自动生成各个平台下的lib
- [x] 包含大量注释和一个示例工程
- [x] 默认引入android ndk中的库
- [ ] 完善readme文件
- [ ] 还有好多要做的,想在没有想好  

环境要求
---
#### 1. iOS
- Xcode 8+
- OSX10.12系统
- cmake3.6+
- 开发者账户

#### 2. android
- android sdk with api 21
- android ndk 10e
- OSX10.12系统

#### 3. OSX
- Xcode 8+
- OSX10.12系统
- cmake3.6+

#### 4. windows
- Windows 7+ only 64bit
- only Visual Studio 2013 with c++ tools
- cmake3.6+  

使用方式
---
#### 1. OSX/iOS/android
```
./make.sh ios|android|osx|all
```
find libs in ./dist

#### 2. windows
点击make.bat,库将会生成在./dist中

更多
---
可以直接查看代码,里面注释很多,如有疑问 mailto: demon@danwi.me  
