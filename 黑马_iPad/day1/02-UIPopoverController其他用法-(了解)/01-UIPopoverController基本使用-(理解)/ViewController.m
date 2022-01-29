//
//  ViewController.m
//  01-UIPopoverController基本使用-(理解)
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController ()<UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark 指向自定义视图
- (IBAction)redButtonClick:(id)sender {
    //1. 创建内容控制器
    TableViewController *tableVC = [TableViewController new];
    
    //2. 创建UIPopoverController
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:tableVC];
    
    //3. 展示控制器 --> 找popover属性, 调用弹出方式
    [popover presentPopoverFromRect:self.redButton.frame inView:self.redButton.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    //4. 通过block来接收值
    tableVC.cellDidClick = ^(UIColor *color) {
        self.redButton.backgroundColor = color;
        
        //5. 取消popover的显示 -->下面2种方法都可以
        //[popover dismissPopoverAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        //下面的属性, 在点击popover的某一行时, 可以进行更换
        //6. 更改内容控制器
//        popover.contentViewController = [UIViewController new];
//        [popover setContentViewController:[UIViewController new] animated:YES];
        
        //7. 更改内容控制器大小
//        popover.popoverContentSize = CGSizeMake(50, 100);
        [popover setPopoverContentSize:CGSizeMake(50, 100) animated:NO];
    };
    
    //8. 设置代理
    popover.delegate = self;
    
    //9. 穿透视图 -->　当popover正在显示的时候, 点击后方的其他视图, 依然能够响应用户的点击事件
    popover.passthroughViews = @[self.blueButton];
}

- (IBAction)blueButtonClick:(id)sender {
    NSLog(@"有种你就点我啊");
}


#pragma mark 代理方法
//屏幕旋转的时候会调用
- (void)popoverController:(UIPopoverController *)popoverController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView *__autoreleasing  _Nonnull *)view
{
    NSLog(@"%s",__func__);
}

//完成消失popover的时候调用
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSLog(@"%s",__func__);
}

//能否消失popover --> 控制点击空白区域消失的
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    // -->　默认就是ＹＥＳ
    return YES;
}



@end
