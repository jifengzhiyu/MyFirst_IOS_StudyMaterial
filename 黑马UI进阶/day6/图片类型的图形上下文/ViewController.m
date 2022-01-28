//
//  ViewController.m
//  图片类型的图形上下文
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
    //开启图片类型的图形上下文
    //UIGraphicsBeginImageContext(CGSizeMake(300, 300));
    //等价于    UIGraphicsBeginImageContextWithOptions(CGSizeMake(300, 300), NO, 1);

    
    
    
    //下面的常用
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(300, 300), NO, 0);
    //NO 上下文不透明
    //最后一个属性和手机 2X 3X 有关
    NSLog(@"%f",[UIScreen mainScreen].scale);
    //打印是3，最后一个参数就写3(缩放因子
    //If you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen.
    //参数是0,自动适应当前屏幕
    //才能不失真
    
    //获取当前的上下文（图片类型
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //拼接路径 同时 把路径添加到上下文中
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddLineToPoint(ctx, 100, 100);
    
    //渲染 到 图片类型的上下文 自带的图片对象
    CGContextStrokePath(ctx);
    
    //通过图片类型的上下文 获取图片对象
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图片类型的图形上下文
    UIGraphicsEndImageContext();
    
    //把获取到的图片 放到 图片框上
    self.imageView.image = image;
    
    //保存到沙盒
    //获取doc路径
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //获取文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"xx.png"];
    //把image转化成NSData
    NSData *data = UIImagePNGRepresentation(image);
    //写到沙盒中
    [data writeToFile:filePath atomically:YES];
    
    
}
@end
