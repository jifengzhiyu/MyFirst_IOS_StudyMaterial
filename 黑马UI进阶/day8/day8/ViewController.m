//
//  ViewController.m
//  day8
//
//  Created by 翟佳阳 on 2021/10/6.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self MyUITapGestureRecognizer];
    //[self MyUILongPressGestureRecognizer];
    //[self MyUISwipeGestureRecognizer];
    [self MyUIRotationGestureRecognizer];
    [self MyUIPinchGestureRecognizer];
    //[self MyUIPanGestureRecognizer];
}

//拖拽
- (void)MyUIPanGestureRecognizer{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:pan];
    
}


- (void)pan:(UIPanGestureRecognizer *)sender{
    //手指在的位置
    CGPoint p = [sender translationInView:sender.view];
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, p.x, p.y);
    //防止叠加，恢复初始状态
    [sender setTranslation:CGPointZero inView:sender.view];
}

//捏合（缩放
-(void)MyUIPinchGestureRecognizer{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.imageView addGestureRecognizer:pinch];
}

- (void)pinch:(UIPinchGestureRecognizer *)sender{
    NSLog(@"%f",sender.scale);
    //从1开始，往0缩放
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, sender.scale, sender.scale);
    //防止叠加，恢复初始状态
    sender.scale = 1;
}

- (void)MyUIRotationGestureRecognizer{
    //旋转（双指头
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [self.imageView addGestureRecognizer:rotation];
    //设置代理
    rotation.delegate = self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
    //返回yes同意多个手势同时使用
    //参数1:设置代理的手势
    //参数2:没有设置代理的手势
}

- (void) rotation:(UIRotationGestureRecognizer *)sender{
    
    //顺时针增，逆时针减
    //松手从零计数
    NSLog(@"%f",sender.rotation);
    
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, sender.rotation);
    //为了防止叠加 旋转度数
    sender.rotation = 0;
}

- (void)MyUISwipeGestureRecognizer{
    //轻扫
    //默认从左往右
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    
    //设置轻扫方向
    swipe1.direction = UISwipeGestureRecognizerDirectionLeft;

    [self.imageView addGestureRecognizer:swipe];
    [self.imageView addGestureRecognizer:swipe1];
}

- (void)swipe:(UISwipeGestureRecognizer *)sender{
    //判断轻扫方向
    if(sender.direction == UISwipeGestureRecognizerDirectionLeft){
    NSLog(@"MyUISwipeGestureRecognizer");
    }
}

- (void)MyUILongPressGestureRecognizer{
    //长按
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    
    //长按多久有反应 默认0.5s
    longPress.minimumPressDuration = 3;
    //误差范围，在长按的时候允许移动的半径 范围
    longPress.allowableMovement = 100;
    
    [self.imageView addGestureRecognizer:longPress];
}

- (void)longPress:(UILongPressGestureRecognizer *)sender{
    //只有在一开始打印
    if(sender.state == UIGestureRecognizerStateBegan){
        NSLog(@"UILongPressGestureRecognizer");

    }
}


- (void)MyUITapGestureRecognizer{
    //敲击
    //1、创建手势对象
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    //需要敲击次数
    tap.numberOfTapsRequired = 2;
    //几根手指
    tap.numberOfTouchesRequired = 2;
    
    //2、对某个view添加手势
    [self.imageView addGestureRecognizer:tap];
}

//3、实现手势的方法
- (void)tap:(UITapGestureRecognizer *)sender{
    NSLog(@"UITapGestureRecognizer");
}

@end
