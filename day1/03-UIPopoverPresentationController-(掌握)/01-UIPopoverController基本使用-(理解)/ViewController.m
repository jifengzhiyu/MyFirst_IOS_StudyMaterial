//
//  ViewController.m
//  01-UIPopoverController基本使用-(理解)
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *redButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//iOS8开始苹果开始整合一些API
#pragma mark 指向BarButtonItem --> iOS8之前的适配方式
- (IBAction)categoryClick:(id)sender {
    //1. 创建内容控制器
    TableViewController *tableVC = [TableViewController new];
    
    //2. 判断设备类型
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        // 如果是iPhone, 就用模态视图弹出
        [self presentViewController:tableVC animated:YES completion:nil];
    } else {
        
        //3. 创建UIPopoverController
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:tableVC];
        
        //4. 展示控制器
        [popover presentPopoverFromBarButtonItem:self.navigationItem.leftBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

//重点掌握下面这个方法
#pragma mark 指向自定义视图 --> iOS8开始的适配
- (IBAction)redButtonClick:(id)sender {
    //1. 创建内容控制器
    TableViewController *tableVC = [TableViewController new];
    
    //2. 设置模态视图的呈现样式
    //UIModalPresentationPopover --> 系统如果发现了设置了此属性
    //系统就知道你要做适配.
    //系统如果检测到了设备是iPhone, 就会模态视图弹出, popover相关的属性就会自动忽略
    //系统如果检测到了设备是iPad, 就会popover弹出
    tableVC.modalPresentationStyle = UIModalPresentationPopover;
    
    //3. 设置popover相关的属性
    //popoverPresentationController: iOS8开始, 给UIViewController添加了一个属性
    // iOS8的新属性, 不需要设置剪头方向. 默认就是Any
    
    // 指向自定义视图: sourceRect sourceView
    tableVC.popoverPresentationController.sourceRect = self.redButton.bounds;
    tableVC.popoverPresentationController.sourceView = self.redButton;
    
    // 执行BarButtonItem: barButtonItem
    //tableVC.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    //4. 使用普通的模态弹出方法
    [self presentViewController:tableVC animated:YES completion:nil];
    
}

@end
