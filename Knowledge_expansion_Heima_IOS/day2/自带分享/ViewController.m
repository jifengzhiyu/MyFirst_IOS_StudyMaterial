//
//  ViewController.m
//  自带分享
//
//  Created by 翟佳阳 on 2021/12/29.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark 点击屏幕开始分享
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1. 判断系统服务是否可用
    if ( ![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        NSLog(@"请先到设置中打开微博并配置账号");
        return;
    };
    
    //2. 创建分享控制器
    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
    //2.1 设置文字
    [composeVC setInitialText:@"世界上一共有10种人, 一种是懂二进制的, 一种是不懂二进制的"];
    
    //2.2 设置图片
    [composeVC addImage:[UIImage imageNamed:@"danshengou"]];
    
    //2.3 设置网址
    [composeVC addURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
    //3. 模态弹出
    [self presentViewController:composeVC animated:YES completion:nil];
    
}
@end
