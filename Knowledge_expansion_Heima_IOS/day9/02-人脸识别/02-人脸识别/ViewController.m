//
//  ViewController.m
//  02-人脸识别
//
//  Created by Romeo on 15/9/25.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "FaceppAPI.h"
#import "UIView+AutoLayout.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 UIImagePickerControllerSourceTypePhotoLibrary,      照片库
 UIImagePickerControllerSourceTypeCamera,            相机
 UIImagePickerControllerSourceTypeSavedPhotosAlbum   相册
 */

#pragma mark 相册

- (IBAction)selectPhotoClick:(id)sender {
    //1. 首先判断是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    
    //2. 创建选择控制器
    UIImagePickerController *picker = [UIImagePickerController new];
    
    //3. 设置类型
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //4. 设置代理
    picker.delegate = self;
    
    //5. 弹出
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark 相机

- (IBAction)selectCameClick:(id)sender {
    
    //1. 首先判断是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    //2. 创建选择控制器
    UIImagePickerController *picker = [UIImagePickerController new];
    
    //3. 设置类型
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //4. 设置代理
    picker.delegate = self;
    
    //5. 弹出
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark Picker代理方法
//点击照片的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //1. 获取选择的图像
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //orientation 0  --> 在做人脸识别, 一定要方向为0
    
    //2. 校正方向
    image = [self fixOrientation:image];
    
    //3. 开始检测
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
//    UIImagePNGRepresentation(<#UIImage * _Nonnull image#>)
    
    //detection/detect	检测一张照片中的人脸信息（脸部位置、年龄、种族、性别等等）
    FaceppResult *result = [[FaceppAPI detection] detectWithURL:nil orImageData:data];
    
    NSLog(@"result = %@",result);
    
    //4. 获取性别,年龄
    
    NSArray *array = result.content[@"face"];
    if (array.count <= 0) {
        
        return;
    }
    NSDictionary *attributeDict = result.content[@"face"][0][@"attribute"];
    NSString *ageValue = attributeDict[@"age"][@"value"];
    NSString *sexValue = [attributeDict[@"gender"][@"value"] isEqualToString:@"Male"] ? @"男性" : @"女性";
    
    //5. 获取脸部位置 (比例值)
    NSDictionary *positionDict = result.content[@"face"][0][@"position"];
    
    CGFloat h = [positionDict[@"height"] floatValue];
    CGFloat w = [positionDict[@"width"] floatValue];
    CGFloat x = [positionDict[@"center"][@"x"] floatValue] - w * 0.5;
    CGFloat y = [positionDict[@"center"][@"y"] floatValue] - h * 0.5;
    
    //6. 画图 --> 画脸到 image 上
    
    //6.1 开启图像图形上下文
    UIGraphicsBeginImageContextWithOptions( image.size, NO, 0);
    
    //6.2 将原图先绘制到底部, 从(0, 0)点开始绘制
    [image drawAtPoint:CGPointZero];
    
    //6.3 画素材图像到图形上下文中
    UIImage *aImage = [UIImage imageNamed:@"cang"];
    
    // 根据原图的大小比例来计算自己的位置
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    [aImage drawInRect:CGRectMake(x * 0.01 * imageW , y * 0.01 * imageH, w * 0.01 * imageW, h * 0.01 * imageH)];
    
    // 320     50%     160
    //50 * 0.01 * 320   = 160
    
    //6.4 合成新的图像
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //6.5 关闭图像上下文
    UIGraphicsEndImageContext();
    
    //7. 在控制器显示
    
    //删除原有约束,然后重新添加
    
    // 删除原有约束
    [self.imageVIew autoRemoveConstraintsAffectingView];
    
    // 设置居中
    [self.imageVIew autoCenterInSuperview];
    
    // 设置宽高 --> 需要根据图片的比例来确定
    //960 * 1080
    
    // 假如我们需要宽度: 屏幕总宽度
    
    // iPhone5 : 320
    // iPhone6 : 375
    CGFloat scale = newImage.size.width / [UIScreen mainScreen].bounds.size.width;
    
    
    //Dimension : 尺寸 --> 宽高
    [self.imageVIew autoSetDimension: ALDimensionWidth toSize:newImage.size.width / scale];
    [self.imageVIew autoSetDimension:ALDimensionHeight toSize:newImage.size.height / scale];
    
    self.imageVIew.image = newImage;
    
    //8. 实现了代理方法一定要取消
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 方向校正
/**
 1. 先将头部朝上
 2. 将镜像反转
 3. 重新合成输出
 */

- (UIImage*)fixOrientation:(UIImage*)aImage
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.height, aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.width, aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage* img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
