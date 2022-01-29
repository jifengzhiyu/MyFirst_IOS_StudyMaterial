//
//  ViewController.m
//  05-视频播放-iOS9
//
//  Created by dream on 15/12/25.
//  Copyright © 2015年 dream. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)playerViewController {
    
    //1. 获取URL地址
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Cupid_高清.mp4" withExtension:nil];
    
    //2. AV播放视图控制器
    AVPlayerViewController *pVC = [AVPlayerViewController new];
    
    //3. 创建player --> 设置时需要传入网址
    pVC.player = [AVPlayer playerWithURL:url];
    
    //4. 开始播放
    [pVC.player play];
    
    //5. 模态弹出
    [self presentViewController:pVC animated:YES completion:nil];
    
    
}

@end
