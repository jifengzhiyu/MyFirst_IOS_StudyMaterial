//
//  ViewController.m
//  day9
//
//  Created by 翟佳阳 on 2021/10/8.
//

#import "ViewController.h"

@interface JFView : UIView
@property (nonatomic, assign) CGRect redRect;

@end

@implementation JFView


- (void)drawRect:(CGRect)rect{
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    [path moveToPoint:CGPointMake(0, 200)];
//    [path addLineToPoint:CGPointMake(200, 250)];
//    [path stroke];
    
    [[UIBezierPath bezierPathWithRect:self.redRect] stroke];
}
@end







@interface ViewController ()<UICollisionBehaviorDelegate>
@property (nonatomic, weak) UIView *redView;
@property (nonatomic, weak) UIView *blueView;
//为了保证动画执行
@property (nonatomic, strong) UIDynamicAnimator *animator;



@end

@implementation ViewController

//优先级最高
//有了loadView就不会找stroyboard里面的view
- (void)loadView{
    
    //默认无颜色：黑色
    self.view = [[JFView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:redView];
    
    self.redView = redView;
    //------------------------------------
    
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.frame = CGRectMake(170, [UIScreen mainScreen].bounds.size.height - 150, 50, 50);
    [self.view addSubview:blueView];
    
    self.blueView = blueView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //1、根据某个范围 创建动画者对象
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //2、根据某个动力学元素 创建行为
#pragma mark - 重力
    //可一次添加多个动力学元素
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.redView]];
    
    //方向1
    //Vector矢量
    //以view的零点 为原点 到CGVectorMake坐标的方向
    //gravity.gravityDirection = CGVectorMake(1, 1);
    
    //方向2
    //以三点钟为0角度
    //gravity.angle = M_PI;
    
    //量级，重力的强度
    gravity.magnitude = 5;
    
#pragma mark - 碰撞
    
    //    //可一次添加多个动力学元素
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.redView, self.blueView]];
    
    //设置边界
    //把引用view的 bounds转化成边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    //再添加边界 法1
    [collision addBoundaryWithIdentifier:@"key" fromPoint:CGPointMake(0, 200) toPoint:CGPointMake(200, 250)];
    
    //再添加边界 法2
    //自定义path法
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.blueView.frame];
    [collision addBoundaryWithIdentifier:@"key1" forPath:path];
    
    
    
    //碰撞模式
    /*
     UICollisionBehaviorModeItems        = 1 << 0,
     //items之间碰撞
     UICollisionBehaviorModeBoundaries   = 1 << 1,
     //和边界碰撞
     UICollisionBehaviorModeEverything   = NSUIntegerMax
     //和边界，items碰撞(默认
     */
    //collision.collisionMode =  UICollisionBehaviorModeItems;
    
#pragma mark - action监听
    //view变动时 就会自动调用block方法
    // When running, the dynamic animator calls the action block on every animation step.
    //dynamic animator的范围内
    collision.action = ^{
        NSLog(@"%@",NSStringFromCGRect(self.redView.frame));
        
        //画出redView的frame
        JFView *jfView = (JFView *)self.view;
        jfView.redRect = self.redView.frame;
        //让JFView重绘
        [self.view setNeedsDisplay];
        
//        if(self.redView.frame.size.width > 105){
//            self.redView.backgroundColor = [UIColor yellowColor];
//        }else{
//            self.redView.backgroundColor = [UIColor redColor];
//        }
        
    };
    
#pragma mark - 代理
    collision.collisionDelegate = self;
    
    //3、将行为添加到动画者中
    [self.animator addBehavior:gravity];
    [self.animator addBehavior:collision];
}



# pragma mark - 代理方法
// The identifier of a boundary created with translatesReferenceBoundsIntoBoundary or setTranslatesReferenceBoundsIntoBoundaryWithInsets is nil
//id为nill默认引用view 的边界
- (void) collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p{
    //需要强转进行判断
    NSString *str = (NSString *)identifier;
    if([str isEqualToString:@"key"]){
        self.redView.backgroundColor = [UIColor yellowColor];
    }
    else
    {
        self.redView.backgroundColor = [UIColor redColor];
        
    }
    
}


@end
