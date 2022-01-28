//
//  ViewController.m
//  核心动画-基本动画
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
    redView.frame = CGRectMake(100, 100, 100, 100);
    redView.backgroundColor = [UIColor redColor];
    self.layer = redView.layer;//根layer
    [self.view addSubview: redView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //基本动画
    //1、创建动画对象
    CABasicAnimation *anim = [[CABasicAnimation alloc] init];
    //2、怎么做动画
    anim.keyPath = @"position.x";
//    anim.fromValue = @(10);
//    anim.toValue = @(300);
    
    //不希望回到原来的位置
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    anim.byValue = @(10);//每次移动多少
    //3、添加动画
    [self.layer addAnimation:anim forKey:nil];
    
}

@end
