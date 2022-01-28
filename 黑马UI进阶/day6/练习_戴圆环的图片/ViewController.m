//
//  ViewController.m
//  练习_戴圆环的图片
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
    
    UIImage *image = [UIImage imageNamed:@"3"];
    
    //线宽
    //左右各宽 5
    CGFloat margin = 10;
    
    //计算图片类型 的图形上下文大小
    CGSize ctxSize = CGSizeMake(image.size.width + 2 * margin, image.size.height + 2 * margin);
    
    //开启图片类型 图形上下文
    UIGraphicsBeginImageContextWithOptions(ctxSize, NO, 0);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //计算圆心
    CGPoint arcCenter = CGPointMake(ctxSize.width * 0.5, ctxSize.height * 0.5);
    
    //计算半径
    
    CGFloat radius = (image.size.width + margin) * 0.5;
    
    //画圆环
    CGContextAddArc(ctx, arcCenter.x, arcCenter.y, radius, 0, 2 * M_PI, 1);
    
    CGContextSetLineWidth(ctx, margin);
    
    //渲染圆环(圆环搞定
    CGContextStrokePath(ctx);
    
    //画头像的显示区域
    CGContextAddArc(ctx, arcCenter.x, arcCenter.y, image.size.width * 0.5, 0, 2 * M_PI, 1);
    
    //裁剪显示的区域
    CGContextClip(ctx);
    
    //画图片
    [image drawAtPoint:CGPointMake(margin, margin)];
    
    //获取图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    //保存相册
    UIImageWriteToSavedPhotosAlbum(image, NULL, NULL, NULL);
    
}


@end
