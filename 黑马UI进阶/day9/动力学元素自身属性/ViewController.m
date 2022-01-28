//
//  ViewController.m
//  动力学元素自身属性
//
//  Created by 翟佳阳 on 2021/10/9.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) UIView *redView;
@property (nonatomic, weak) UIView *blueView;
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
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(170, [UIScreen mainScreen].bounds.size.height - 50, 50, 50)];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    self.blueView = blueView;
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    //1、动画者
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //2、行为
    //重力
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.redView]];
    
    //碰撞
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.redView, self.blueView]];
    
    //把引用的view设置为边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    
    //动力学元素 自身属性
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.redView, self.blueView]];
    
    itemBehavior.friction = 0;
    //弹性
    itemBehavior.elasticity = 1;
    //密度
    //默认1
    //itemBehavior.density = 10;
   
    //3、添加行为到 动画者
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
    [self.animator addBehavior:itemBehavior];
    
}
@end
