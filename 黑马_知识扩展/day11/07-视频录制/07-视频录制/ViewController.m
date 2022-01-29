//
//  ViewController.m
//  07-视频录制
//
//  Created by dream on 15/12/25.
//  Copyright © 2015年 dream. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) MPMoviePlayerController *mpC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)movieClick:(id)sender {
    //1. 判断是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"不可用");
        return;
    }
    
    //2. 创建图像选择器
    UIImagePickerController *picker = [UIImagePickerController new];
    
    //3. 设置类型
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //4. 设置媒体类型
    picker.mediaTypes = @[(NSString *)kUTTypeMovie];
    
    //5. 设置相机检测模式
    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    
    //6. 设置视频的质量
    picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    //7. 设置代理
    picker.delegate = self;
    
    //8. 模态弹出
    [self presentViewController:picker animated:YES completion:nil];
}

//UIImagePickerController 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"info: %@",info);
    
    //1. 获取媒体类型
    NSString *mediaTyep = info[UIImagePickerControllerMediaType];
    
    //2. 判断是否是视频的媒体类型
    
    id url = info[UIImagePickerControllerMediaURL];
    
    if ([mediaTyep isEqualToString:(NSString *)kUTTypeMovie]) {
        if (self.mpC == nil) {
            self.mpC = [MPMoviePlayerController new];
            self.mpC.view.frame = self.view.bounds;
            [self.view addSubview:self.mpC.view];
        }
        self.mpC.contentURL = url;
        [self.mpC play];
    }
    
    //3. 保存视频
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        //3.1 创建ALAssetsLibrary对象
        ALAssetsLibrary *assetsLibrary = [ALAssetsLibrary new];
        
        //3.2 调用writeVideoAtPathToSavedPhotosAlbum即可
        //前面的URL, 需要传入要保存的视频的URL. 
        [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:url completionBlock:nil];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
