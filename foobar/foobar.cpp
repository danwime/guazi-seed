//
// Created by 李雨田 on 2016/12/14.
//
#include <iostream>

using namespace std;

//以c的方式导出
#ifdef __cplusplus
extern "C" {
#endif

//如果想被外部访问,请一定要在前面加 EXPORT 导出这个符号
//另外针对iOS我做了符号裁剪,这里必须加 EXPORT,还需要编辑export.txt文件
EXPORT int add(int a, int b) {
    return a + b;
}

EXPORT void show(const char *content) {
    cout << content << endl;
}

#ifdef __cplusplus
}
#endif