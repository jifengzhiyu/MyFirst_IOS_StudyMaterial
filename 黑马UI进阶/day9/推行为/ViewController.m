//
//  ViewController.m
//  推行为
//
//  Created by 翟佳阳 on 2021/10/9.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) UIView *redView;
@property (nonatomic, strong) UIDynamicAnimator *animator;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    self.redView = redView;
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:t.view];
    
    //1、动画者
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //2、行为
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.redView] mode:UIPushBehaviorModeContinuous];
    
    //量级
    push.magnitude = 1;
    
    //计算偏移量
    CGFloat offsetX = p.x - self.redView.center.x;
    CGFloat offsetY = p.y - self.redView.center.y;
    
    //方向 与 偏移量二选一
    //默认 三点钟方向
    //push.angle = M_PI;
    
    push.pushDirection = CGVectorMake(offsetX, offsetY);
    
    //3、添加行为到 动画者
    [self.animator addBehavior:push];
    
}
@end
