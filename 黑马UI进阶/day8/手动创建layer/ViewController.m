//
//  ViewController.m
//  手动创建layer
//
//  Created by 翟佳阳 on 2021/10/8.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor redColor].CGColor;
    //分开设置
    layer.position = CGPointMake(200, 200);
    layer.bounds = CGRectMake(0, 0, 100, 100);
    
    layer.contents = (__bridge id)[UIImage imageNamed:@"36"].CGImage;
    
    //添加到控制器的layer
    [self.view.layer addSublayer:layer];
    self.layer = layer;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *t = touches.anyObject;
//    //获取手指位置
//    CGPoint p = [t locationInView:t.view];
    //让layer中心跑到手指位置
    //它自带动画（隐式动画：改变可动画属性后，系统自带的动画，就是隐式动画
    //根layer没有隐式动画
    //layer属性里面注释有 Animatable: 可动画属性
    
//    self.layer.position = p;
    //透明度
    //self.layer.opacity = 0;
    
    //self.layer.bounds = CGRectMake(0, 0, 200, 200);
    
    
    //禁用隐式动画
    //开启事务
//    [CATransaction begin];
//    //禁用隐式动画
//    [CATransaction setDisableActions:YES];
//    self.layer.position = p;
//    //提交事务
//    [CATransaction commit];
    
    
    //旋转
    //参数0，不在那个坐标轴上面旋转
    //self.layer.transform = CATransform3DRotate(self.layer.transform, M_PI_4, 1, 1, 0);
    
    //缩放(z无效，压薄，压厚
    //self.layer.transform = CATransform3DScale(self.layer.transform, 1, 1.5, 0.5);
    
    //平移（z无效,离屏幕远近
    self.layer.transform = CATransform3DTranslate(self.layer.transform, 10, 20, 0);
}

@end
