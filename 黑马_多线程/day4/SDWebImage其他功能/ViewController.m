//
//  ViewController.m
//  SDWebImage其他功能
//
//  Created by 翟佳阳 on 2021/10/28.
//

#import "ViewController.h"
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"2.gif" ofType:nil];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    self.imageView.image = [UIImage sd_imageWithGIFData:data];
    
    //进度条
    NSURL *url = [NSURL URLWithString:@"https://img0.baidu.com/it/u=1707861540,3281062113&fm=26&fmt=auto"];
    [self.imageView sd_setImageWithURL:url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            float progress = receivedSize * 1.0 / expectedSize;
            NSLog(@"下载进度:%f",progress);
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            NSLog(@"完成");
        }];
}


@end
