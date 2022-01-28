//
//  ViewController.m
//  获取裁剪过后的图片'
//
//  Created by 翟佳阳 on 2021/10/5.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIImage *image = [UIImage imageNamed:@"22"];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5, 0, 2 * M_PI, 1);
    CGContextClip(ctx);
    [image drawAtPoint:CGPointZero];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //测试
     self.imageView.image = newImage;
    
    //保存到相册
    // Adds a photo to the saved photos album.  The optional completionSelector should have the form:
    //  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
    //selector方法只能用这个
    //最后一个参数：标记
    //就是下面固定方法的contextInto
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), @"231231231");
    
   
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"成功---%@",contextInfo);
}

- (void)done{
    NSLog(@"保存完成");
}

@end
