@echo off

echo build win32...
echo --------------------------------
cd %~dp0
if exist dist\build\win\win32 rmdir dist\build\win\win32 /s /q
mkdir dist\build\win\win32
cd dist\build\win\win32
cmake -G "Visual Studio 12 2013" -D package=win ../../../../
cmake --build ./ --config Release

echo.
echo build win64...
echo --------------------------------
cd %~dp0
if exist dist\build\win\win64 rmdir dist\build\win\win64 /s /q
mkdir dist\build\win\win64
cd dist\build\win\win64
cmake -G "Visual Studio 12 2013 Win64" -D package=win ../../../../
cmake --build ./ --config Release

echo.
echo package...
echo --------------------------------
cd %~dp0
if exist dist\win rmdir dist\win /s /q
mkdir dist\win
mkdir dist\win\win64
mkdir dist\win\win32

REM 拷贝生成的dll到对应位置
copy dist\build\win\win64\foobar\Release\foobar.dll dist\win\win64\foobar.dll
copy dist\build\win\win32\foobar\Release\foobar.dll dist\win\win32\foobar.dll

echo all done

@pause