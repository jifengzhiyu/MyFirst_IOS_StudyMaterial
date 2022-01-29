//
//  ViewController.m
//  01-音效
//
//  Created by dream on 15/12/23.
//  Copyright © 2015年 dream. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HMAudioTools.h"

/**
 1. 导入AVFoundation框架
 2. 创建音效文件
 3. 播放音效文件
 
 音效: 非常短的音乐, 一般来说30秒以内的声音, 都算作音效
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark 点击播放音效
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1. 获取URL地址
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"buyao.wav" withExtension:nil];
    
    //2. 调用工具类播放音效
    //[HMAudioTools playSystemSoundWithURL:url];
    
    [HMAudioTools playAlertSoundWithURL:url];
    
}

#pragma mark 基本实用
- (void)baseUse
{
    //1. 创建URL地址
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"buyao.wav" withExtension:nil];
    
    //2. 系统音效文件 SystemSoundID = UInt32
    SystemSoundID soundID;
    
    //3. 创建音效文件
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
    
    //4. 播放音效文件
    //4.1 不带震动的播放
    //AudioServicesPlaySystemSound(soundID);
    
    //4.2 带振动的播放 --> 真机才有效果
    AudioServicesPlayAlertSound(soundID);
    
    //5. 如果不需要播放了, 需要释放音效所占用的内存
    //AudioServicesDisposeSystemSoundID(soundID);
    
}

#pragma mark 当前控制器收到内存警告时会调用的方法
- (void)didReceiveMemoryWarning
{
    // 局部音效需要在这里进行释放
    [HMAudioTools clearMemory];
    NSLog(@"%s",__func__);
}

@end
