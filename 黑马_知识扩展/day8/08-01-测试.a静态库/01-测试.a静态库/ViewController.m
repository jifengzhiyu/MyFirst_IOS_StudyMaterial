//
//  ViewController.m
//  01-测试.a静态库
//
//  Created by Romeo on 15/9/24.
//  Copyright © 2015年 itheima. All rights reserved.
//

/**
 1. Undefined symbols for architecture x86_64 / i386 /arm64 / armv7s / armv7 :
 原因: 静态库的架构不对 真机/模拟器 没有架构
 解决方法: 检查第三方类库的架构版本 真机/模拟器
 
 2. Undefined symbols for architecture i386:
 原因: 真机和模拟器也是区分多种架构的
 
 模拟器架构:
 
 i386    : 4S / 5        32位
 x86_64  : 5S ---> 6S    64位
 
 真机架构: 
 armv7: 4 / 4S
 armv7s: 5 / 5C  最特殊的一代 默认已经不支持输出
 arm64: 5S --> 6S
 
 
 3. 怎么查看架构
 lipo -info 静态库. a
 
 4. 合成多个版本架构

 需求: 合成模拟器所需要的全部架构   如果使用方式一合成5种架构: 执行4次
 方式一: 使用合成命令lipo -create 静态库1.a 静态库2.a -output 新静态库.a
 
 方式二: 设置编译当前架构为 NO (只针对模拟器/真机, 需要运行两次)  方式二合成简单: 执行1次
 Build Active Architecture Only --->Debug---->NO
                               ----->release--->NO
 
 如果需要合并真机的所有架构 以及 模拟器的所有架构, 继续使用方式一合成
 
 
 需求: 合成5种架构
 
 (友盟5种架构 首先合成模拟器的2种架构,  再合成真机的3种架构 , 在将两个架构合成)
 
 默认合成之后, 只有4种架构, 缺少 armv7s
 
 armv7S 这个架构, 在2014年10月份的 Xcode 更新中, 取消了默认输出, 如果想要输出, 就需要配置手动添加
 
 5. 是否需要合成静态库的真机/模拟器 (每一种架构都会占用一定的大小)
 不合成通用文件:  百度 文件体积小    好处: 真机调试一定不用模拟器的架构  
 合成通用文件:   友盟 文件体积大     好处: 是调试时不用区分真机和模拟器
 
 (如果开发遇到这种问题, 开发时, 先合并, 发布时,使用真机的架构版本)

 
 6. Release 和 Debug 的区别
 应该输出 Release 版本
 Debug   : 有丰富的调试语句和代码 当前模式下会输出(NSLog)
 Release : 不会有丰富的调试语句和代码   文件体积会变小, 执行速度会变快 , 实际上体现不出太大区别(对用户来说无太大影响)
 
 
 7. 图片资源包
 如果静态库中的图像名称, 跟项目中资源中的图像名称, 如果发生重名, 可能就出现问题
 应该使用 Bundle(文件夹) .bundle
 
 8. Xcode7创建项目时, 默认会包含 Bitcode (YES)
 如果使用之前项目创建的第三库(友盟), 真机运行会报错. 解决方式, Setting--> 搜索 Enable Bitcode --> 改为 NO
 
 */

#import "ViewController.h"
#import "HMTool.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%ld",(long)[HMTool sum1:250 addSum2:38]);
    
    self.imageView.image = [HMTool loadImage:@"cang"];
}
@end
