//
//  ViewController.m
//  CALayer基本使用
//
//  Created by 翟佳阳 on 2021/10/7.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *redView = [[UIView alloc] init];
    redView.frame = CGRectMake(100, 100, 100, 100);
    redView.backgroundColor = [UIColor redColor];
    
    //1、边框（往里面加边框
    redView.layer.borderWidth = 10;
    redView.layer.borderColor = [UIColor grayColor].CGColor;
    
    //2、阴影
    //阴影的偏移量
    redView.layer.shadowOffset = CGSizeZero;
    redView.layer.shadowColor = [UIColor blueColor].CGColor;
    //阴影半径
    redView.layer.shadowRadius = 50;
    //一定要设置，，阴影透明度
    redView.layer.shadowOpacity = 1;
    
    //3、圆角
    redView.layer.cornerRadius = 50;
    //剪裁超过该图层的部分
    redView.layer.masksToBounds = YES;
    
    //4、bounds,也就是 view显示的大小
    //redView.layer.bounds = CGRectMake(0, 0, 200, 200);
    
    //5、position属性默认 == view.center
    //redView.layer.position = CGPointMake(0, 0);
    //设置图层的frame 就要单独设置bonds position,不然有bug
    
    //6、设置内容（图片
    //__bridge强转类型 oc c
    //id是需要转换成为的类型
    /* An object providing the contents of the layer, typically a CGImageRef,
     * but may be something else. (For example, NSImage objects are
     * supported on Mac OS X 10.6 and later.) Default value is nil.
     * Animatable. */
    //CGImage是C语言
    redView.layer.contents = (__bridge id)[UIImage imageNamed:@"35"].CGImage;
    
    
    [self.view addSubview:redView];
}



@end
