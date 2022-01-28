//
//  ViewController.m
//  附着行为-items
//
//  Created by 翟佳阳 on 2021/10/9.
//


#import "ViewController.h"

@interface JFView : UIView

@property (nonatomic, assign) CGPoint start;
@property (nonatomic, assign) CGPoint end;



@end
@implementation JFView

- (void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.start];
    [path addLineToPoint:self.end];
    [path stroke];
}

@end



@interface ViewController ()
@property (nonatomic, weak) UIView *redView;
@property (nonatomic, weak) UIView *blueView;


@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attach;




@end

@implementation ViewController

- (void)loadView{
    
    self.view = [[JFView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.frame = CGRectMake(100, 100, 100, 100);
    redView.alpha = 0.4;
    
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.frame = CGRectMake(250, 100, 100, 100);
    blueView.alpha = 0.4;
    
    [self.view addSubview:blueView];
    
    self.redView = redView;
    self.blueView = blueView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:t.view];
    
    //1、创建动画者对象
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //2、创建行为
    //anchor 连接的点
    //self.attach = [[UIAttachmentBehavior alloc] initWithItem:self.redView attachedToAnchor:p];
    
    //self.attach = [[UIAttachmentBehavior alloc] initWithItem:self.redView attachedToItem:self.blueView];
    
    //偏移量 附着点
    //偏移量：以view为原点，形成四个坐标区域
    self.attach = [[UIAttachmentBehavior alloc] initWithItem:self.redView offsetFromCenter:UIOffsetMake(20, 20) attachedToAnchor:p];
    
    //固定长度
    //self.attach.length = 100;
    
    //减幅
    self.attach.damping = 0.5;
    //弹性
    self.attach.frequency = 1;
     
    //加一个重力行为
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.redView]];
    
    //3、把行为添加到动画者对象中
    [self.animator addBehavior:self.attach];
    [self.animator addBehavior:gravity];
}

//需要跟着手指的移动而移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:t.view];

    self.attach.anchorPoint = p;

    //block是强指针，self是强指针,在 强指针里面 使用强指针会造成循环引用
    __weak ViewController *weakSelf = self;
    self.attach.action = ^{
        JFView *jfView = (JFView *)weakSelf.view;
        jfView.start = weakSelf.redView.center;
        jfView.end = p;

        [weakSelf.view setNeedsDisplay];
    };
}
@end



