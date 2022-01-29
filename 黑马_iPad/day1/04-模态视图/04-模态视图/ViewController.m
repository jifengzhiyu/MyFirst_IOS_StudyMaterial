//
//  ViewController.m
//  04-模态视图
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 一. 呈现样式
 modalPresentationStyle
 
 常用属性
 UIModalPresentationFullScreen
 UIModalPresentationPageSheet 宽度保持768, 高度跟屏幕几乎一致(除去状态栏)
 UIModalPresentationFormSheet 弹窗样式, 显示在屏幕的最中间 --> iPhone也可以用
 
 二. 转场样式
 modalTransitionStyle
 
 常用属性
 UIModalTransitionStyleCoverVertical
 UIModalTransitionStyleFlipHorizontal 翻转效果
 UIModalTransitionStyleCrossDissolve  淡入淡出
 UIModalTransitionStylePartialCurl    翻页效果 --> 电子书软件会用
 
 注意: 翻页效果, 如果不是全屏, 就不能使用
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NextViewController *nextVC = [NextViewController new];
    
    //呈现样式
    nextVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
    //转场样式
    nextVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:nextVC animated:YES completion:nil];
}

@end
