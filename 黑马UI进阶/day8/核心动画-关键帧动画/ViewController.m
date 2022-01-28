//
//  ViewController.m
//  核心动画-关键帧动画
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
    UIView *redView = [[UIView alloc] init];
    redView.frame = CGRectMake(100, 100, 20, 20);
    redView.backgroundColor = [UIColor redColor];
    self.layer = redView.layer;//根layer
    [self.view addSubview: redView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CAKeyframeAnimation *anim = [[CAKeyframeAnimation alloc] init];
    
    anim.keyPath = @"position";
    
    //法1:NSValue-------------------------------------------------
//    NSValue *v1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
//    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(150, 100)];
//    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(100, 150)];
//    NSValue *v4 = [NSValue valueWithCGPoint:CGPointMake(150, 150)];
//
//    //关键数据
//    anim.values = @[v1,v2,v3,v4];
    
    //法2:路径-------------------------------------------------
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:2 * M_PI clockwise:1];
    
    anim.path = path.CGPath;
    
    //动画时间
    anim.duration = 2;
    anim.repeatCount = INT_MAX;
    
    [self.layer addAnimation:anim forKey:nil];
}

@end
