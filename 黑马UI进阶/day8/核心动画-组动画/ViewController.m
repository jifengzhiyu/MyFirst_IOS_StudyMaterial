//
//  ViewController.m
//  核心动画-组动画
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
    //创建组动画
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    
#pragma mark - 自转
    CABasicAnimation *anim = [[CABasicAnimation alloc] init];
    
    anim.keyPath = @"transform.rotation";
    anim.byValue = @(2 * M_PI * 10);
    
#pragma mark - 周转 关键帧动画
    CAKeyframeAnimation *anim1 = [[CAKeyframeAnimation alloc] init];
    anim1.keyPath = @"position";
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:2 * M_PI clockwise:1];
    
    anim1.path = path.CGPath;
    
    group.duration = 3;
    group.repeatCount = INT_MAX;
    group.animations = @[anim, anim1];
    [self.layer addAnimation:group forKey:nil];
    
}

@end
