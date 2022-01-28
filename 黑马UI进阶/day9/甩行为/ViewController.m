//
//  ViewController.m
//  甩行为
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
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:redView];
    
    self.redView = redView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:t.view];
    
    //1、动画者对象
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //2、创建行为
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.redView snapToPoint:p];
    
    //减速程度 0 - 1
    snap.damping = 0;
    
    //3、把行为添加到动画者中
    [self.animator addBehavior:snap];
    
}

@end
