//
//  ViewController.m
//  OC单例
//
//  Created by 翟佳阳 on 2021/11/25.
//

#import "ViewController.h"
#import "NetWorkTools.h"
// ProductName-Swift.h 注意 ProductName 不能包含中文和数字的组合`-`
// 注意：Swift 调用 OC 不会有问题
// 但是 OC 无法访问 Swift 中的特殊语法，例如：枚举！
#import "OC单例-Swift.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@",[NetWorkTools sharedNetWorkTools]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%@",[NetWorkTools sharedNetWorkTools]);
    NSLog(@"%@",[SoundTools sharedTools4]);
}


@end
