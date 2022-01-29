 //
//  ViewController.m
//  UIDynamic
//
//  Created by 翟佳阳 on 2022/1/6.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *blueView;


/** 物理仿真器*/
@property (strong, nonatomic) UIDynamicAnimator *animator;

/** 捕捉行为*/
@property (strong, nonatomic)  UISnapBehavior *snap;

@end

@implementation ViewController
- (UIDynamicAnimator *)animator
{
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.redView.transform = CGAffineTransformRotate(self.redView.transform, 40);

    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    [self gravity];
////    [self gravityAndCollision_1];
////    [self gravityAndCollision_2];
//}

#pragma mark 点击屏幕开始重力和碰撞仿真行为
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.snap == nil) {
        // iOS8以前, 是无法更改point, 如果要更改, 需要移除并重新添加
        //0. 获取点击的点
        CGPoint point = [[touches anyObject] locationInView:self.view];
        
        //1. 添加snap之前, 需要移除之前的行为
        
        // 如果需要更改snapPoint, 此方法就不需要写了
        //[self.animator removeAllBehaviors];
        
        //2. 创建物理仿真行为(顺便设置物理仿真元素)
        // Point自行设置即可
        self.snap = [[UISnapBehavior alloc] initWithItem:self.redView snapToPoint:point];
        
        //2.1 设置 振幅 减震效果  0最大, 1最小
        self.snap.damping = 0.5;
        //3. 将仿真行为添加到仿真器中
        [self.animator addBehavior:self.snap];
    }
    
    //2.2 设置位置
    static int i = 1;
    self.snap.snapPoint = CGPointMake(200, 50 * i);
    i++;

}

//点击屏幕开始重力+碰撞仿真行为
- (void)gravityAndCollision_2
{
    //1. 创建物理仿真器(顺便设置仿真范围)
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //2. 创建物理仿真行为(顺便设置物理仿真元素)
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.redView]];
    
    //2.1 向量, 重力方向
    gravity.gravityDirection = CGVectorMake(3, 1);
    
    //2.2 角度 默认就是90°, M_PI_2
    gravity.angle = M_PI_2;
    
    //2.3 重力加速度 越小越慢
    gravity.magnitude = 30;
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.redView, self.blueView]];
    
    // 设置参考引用的视图的边框为自己的边框
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    // 设置碰撞的边界
//        CGPoint fromPoint = CGPointMake(0, [UIScreen mainScreen].bounds.size.height * 0.2);
//        CGPoint toPoint = CGPointMake(375, [UIScreen mainScreen].bounds.size.height * 0.8);
//        [collision addBoundaryWithIdentifier:@"collision" fromPoint:fromPoint toPoint:toPoint];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 375, 375)];
    [collision addBoundaryWithIdentifier:@"collision" forPath:bezierPath];
    
    //3. 将仿真行为添加到仿真器中
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

//点击屏幕开始重力+碰撞仿真行为
- (void)gravityAndCollision_1
{
    //1. 创建物理仿真器(顺便设置仿真范围)
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //2. 创建物理仿真行为(顺便设置物理仿真元素)
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.redView]];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.redView, self.blueView]];
    
    // 设置参考引用的视图的边框为自己的边框
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    //3. 将仿真行为添加到仿真器中
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}

//点击屏幕开始重力仿真行为
- (void)gravity
{
    //1. 创建物理仿真器(顺便设置仿真范围)
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //2. 创建物理仿真行为(顺便设置物理仿真元素)
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.redView]];
    
    //3. 将仿真行为添加到仿真器中
    [self.animator addBehavior:gravity];
}

@end
