//
//  ViewController.m
//  06-视频截图
//
//  Created by dream on 15/12/25.
//  Copyright © 2015年 dream. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark 点击屏幕, 开始截图
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1. URL
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Cupid_高清.mp4" withExtension:nil];
    
    //2. 获取资源
    AVAsset *asset = [AVAsset assetWithURL:url];
    
    //3. 创建 资源图像生成器
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    //4. 开始生成图像
    
    //Times : 用来表示影片的时间的值
    
    //value: 帧数
    //timescale: 当前视频的每秒的帧数
    //第60秒
    CMTime time = CMTimeMake(60, 1);
    
    NSValue *value = [NSValue valueWithCMTime:time];
    
    [imageGenerator generateCGImagesAsynchronouslyForTimes:@[value] completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        
        //5. 主线程中更新UI
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithCGImage:image];
        });
        
    }];
}

@end
