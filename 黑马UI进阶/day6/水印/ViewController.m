//
//  ViewController.m
//  水印
//
//  Created by 翟佳阳 on 2021/10/5.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"23"];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //画图片
    [image drawAtPoint:CGPointZero];
    NSString *str = @"阿巴巴啊吧吧吧";
    //画文字水印
    [str drawAtPoint:CGPointMake(20, 20) withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20] }];
    
    UIImage *logo = [UIImage imageNamed:@"13"];
    //画图片水印
    [logo drawAtPoint:CGPointMake(image.size.width * 0.7, image.size.height * 0.7)];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIImageWriteToSavedPhotosAlbum(image, NULL, NULL, NULL);
    UIGraphicsEndImageContext();
    
}


@end
