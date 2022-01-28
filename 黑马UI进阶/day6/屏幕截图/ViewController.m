//
//  ViewController.m
//  屏幕截图
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
    
    //开启图片类型的图形上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //截图 把view的内容放到上 下文中 并渲染
    [self.view.layer renderInContext:ctx];
    
    //取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    //保存相册
    UIImageWriteToSavedPhotosAlbum(image, NULL, NULL, NULL);
    
}


@end
