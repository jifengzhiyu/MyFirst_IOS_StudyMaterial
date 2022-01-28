//
//  ViewController.m
//  毛毛虫
//
//  Created by 翟佳阳 on 2021/10/9.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *att;
@property (nonatomic, strong) NSMutableArray *bogys;




@end

@implementation ViewController

- (NSMutableArray *)bogys{
    if(!_bogys){
        _bogys = [NSMutableArray array];
    }
    return _bogys;
}

- (UIDynamicAnimator *)animator{
    if(!_animator){
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i = 0; i < 9; i++) {
        UIView *wormView = [[UIView alloc] init];
        
        //计算frame
        CGFloat w = 30;
        CGFloat h = 30;
        CGFloat x = i * w;
        CGFloat y = 100;
        
        wormView.frame = CGRectMake(x, y, w, h);
        wormView.backgroundColor = [UIColor redColor];
        
        //设置圆角
        wormView.layer.cornerRadius = w * 0.5;
        wormView.layer.masksToBounds = YES;
        
        if(i == 8){
            wormView.frame = CGRectMake(x, y - h * 0.5, 2 * w, 2 * h);
            wormView.backgroundColor = [UIColor blueColor];
            wormView.layer.cornerRadius = w;
            
            //添加一个拖拽手势
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
            //对某个view使用这个手势
            [wormView addGestureRecognizer:pan];
        }
        [self.view addSubview:wormView];
        [self.bogys addObject:wormView];
    }
    for(int i = 0; i < self.bogys.count -1; i++){
        //附着
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:self.bogys[i] attachedToItem:self.bogys[i+1]];
        [self.animator addBehavior:attachment];
        
    }
    
    //重力
    UIGravityBehavior *g = [[UIGravityBehavior alloc] initWithItems:self.bogys];
    [self.animator addBehavior:g];
    
    //边界碰撞
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:self.bogys];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
}


# pragma mark - 实现拖拽手势的方法
- (void)pan:(UIPanGestureRecognizer *)sender{
    CGPoint p = [sender locationInView: self.view];
    
    //1、创建动画者对象
    
    //2、创建附着行为
    //为了避免每次拖动都创建一个新的attach行为，将行为设为一个
    if(!self.att){
        UIAttachmentBehavior *att = [[UIAttachmentBehavior alloc] initWithItem:sender.view attachedToAnchor:p];
        self.att = att;
    }
    
    //再更新一遍anchor
    self.att.anchorPoint = p;
    
    
    //添加到动画者对象
    [self.animator addBehavior:self.att];
    
    if(sender.state == UIGestureRecognizerStateEnded){
        //消除手指的附着行为
        [self.animator removeBehavior:self.att];
    }
}

@end
