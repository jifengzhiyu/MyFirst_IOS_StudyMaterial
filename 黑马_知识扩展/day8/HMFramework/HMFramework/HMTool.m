//
//  HMTool.m
//  HMFramework
//
//  Created by Romeo on 15/9/24.
//  Copyright © 2015年 itheima. All rights reserved.
//

/**
 Xcode6开始, 才有了 Framework 工程模板. 以前基本都是. a
 现在的第三方, 已经逐步开始转向 Framework 静态库(百度 , 支付宝)
 Xcode6以前, 也可以制作 Framework. 需要去 Github 上寻找模板文件. (使用几率很低,Xcode6出现后, 此模板文件不再更新)
 
 1. 导出头文件, 跟. a 不一样. 需要将公开的头文件移到 Public 下
 2. 制作 Framework, 默认是动态库
 https://blog.csdn.net/xisan_10/article/details/102823971
 3. 自己制作的动态库 在使用时, 需要添加Embedded Binaries --> 此选项的意思就是将动态库的代码转换成二进制文件, 此时就无关动态还是静态
 //在General下，已经没有“Embedded Binaries",这个选项，多出了如下的界面
 https://www.pianshen.com/article/39641152114/
 4. 动态库提交 APPStore 时, 需要更改为静态库. 去 setting 中搜索 Mach-O type , 改为 Static
 5. Framework 的静态库, 直接使用即可. 不需要设置Embedded Binaries
 */

#import "HMTool.h"

@implementation HMTool

+ (void)sayHello
{
    NSLog(@"hello ");
}

@end
