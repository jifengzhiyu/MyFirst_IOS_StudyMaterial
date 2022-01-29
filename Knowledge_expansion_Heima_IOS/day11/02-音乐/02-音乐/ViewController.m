//
//  ViewController.m
//  02-音乐
//
//  Created by dream on 15/12/23.
//  Copyright © 2015年 dream. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

/**
 1. 需要使用AVFoundatiaon框架
 2. 创建音乐播放器
 3. 根据需求, 进行播放/暂停/停止
 */

@interface ViewController ()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建音乐播放器
    
    //1. 获取URL路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"我爱你你却爱着她.mp3" withExtension:nil];
    
    //2. 创建一个error对象
    NSError *error;
    
    //3. 创建音乐播放器
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (error) {
        NSLog(@"有错误产生");
    }
    
}

- (IBAction)playClick:(id)sender {
    //1. 准备播放 --> 将音频文件加载到内存中 --> 这句话可以不写 --> play会隐式调用prepareToPlay方法. 但是规范来说, 还是会写上
    [self.player prepareToPlay];
    
    //2. 开始播放
    [self.player play];
}

- (IBAction)pauseClick:(id)sender {
    
    
    self.player.isPlaying == YES? [self.player pause] : [self.player play];
    
    // 暂停播放
//    [self.player pause];
}

- (IBAction)stopClick:(id)sender {
    // 停止播放
    [self.player stop];
    
    // 归零操作 / 时间重置 currentTime--> 秒为单位
    self.player.currentTime = 0;
}


@end
