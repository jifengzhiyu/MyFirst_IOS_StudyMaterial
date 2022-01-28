//
//  JFRotateView.m
//  day11
//
//  Created by 翟佳阳 on 2021/10/12.
//

#import "JFRotateView.h"




@interface JFRotateView ()
@property (weak, nonatomic) IBOutlet UIImageView *rotateImage;
@property (nonatomic, weak) UIButton *currentButton;


@end
@implementation JFRotateView



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)roteView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"JFRotateView" owner:nil options:nil][0];
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    //创建按钮
    for (int i = 0; i < 12; i++) {
        UIButton *btn = [[UIButton alloc] init];
        //btn.backgroundColor = [UIColor redColor];

        //设置图片
        //获取
        UIImage *image = [UIImage imageNamed:@"LuckyAstrology"];
        image = [self clipImageWithImage:image withIndex:i];
        
        [btn setImage:image forState:UIControlStateNormal];
        
        
        //获取
        UIImage *imagePress = [UIImage imageNamed:@"LuckyAstrologyPressed"];
        imagePress = [self clipImageWithImage:imagePress withIndex:i];
        [btn setImage:imagePress forState:UIControlStateSelected];
        //设置背景图片
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        //在btn内部 把imageView往上移动(设置边距
//        UIButtonConfiguration *con = [UIButtonConfiguration plainButtonConfiguration];
//        con.imagePlacement.NSDirectionalRectEdgeTop =
        //尝试失败，还是用之前的那个吧,虽然过期了
        [btn setImageEdgeInsets:UIEdgeInsetsMake(-50, 0, 0, 0)];
        
        
        [self.rotateImage addSubview:btn];
        [_rotateImage setUserInteractionEnabled:YES];

        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //[self btnClick:btn];
        btn.enabled = YES;
    }
    
}

//按钮的点击事件，一次只能有一个按钮被选中
- (void)btnClick:(UIButton *)sender{
    //初始化
    self.currentButton.selected = NO;
    
    //设置被选中
    sender.selected = YES;
    
    //记录被选中的btn
    self.currentButton = sender;
    
    //NSLog(@"看看触发方法没");
    
    
}

//设置布局 子控件位置
- (void)layoutSubviews{
    [super layoutSubviews];
    //自己创建的xib 可以使用系统subviews
    for (int i = 0; i < self.rotateImage.subviews.count; i++) {
        
        
        //获取btn
        UIButton *btn = self.rotateImage.subviews[i];
        //创建tag
        btn.tag = i;
        
        btn.bounds = CGRectMake(0, 0, 68, 143);
        btn.center = _rotateImage.center;
        //设置锚点
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        
        //设置旋转
        CGFloat angle = 2 * M_PI / 12 * i;
        btn.transform = CGAffineTransformMakeRotation(angle);
    }
    
}

////自己创建方法，为了切割图片
- (UIImage *)clipImageWithImage:(UIImage *)image withIndex:(NSInteger)index{
    //计算rect
    //图片根据像素计算而不是点（要乘以缩放的值
    //不知道为什么，这里图片应该有问题，这里只能手动随机调整，使它看得到
    CGFloat w = image.size.width / 12 * [UIScreen mainScreen].scale * 0.658;
    CGFloat h = image.size.height * [UIScreen mainScreen].scale;
    CGFloat x = index * w;
    CGFloat y = 0;

    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(x, y, w, h));
    //NSLog(@"%@", NSStringFromCGRect(CGRectMake(x, y, w, h)));

    
    return [[UIImage alloc] initWithCGImage:imageRef scale:2 orientation:UIImageOrientationUp];


}

//旋转方法
- (void)startRotate{
    //和屏幕刷新频率保持一致
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotate)];
    
    //添加到主运行循环中
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    self.link = link;
}

- (void)rotate{
    //自转
    //速度，假设一秒钟调用60次
    //2 * M_PI /60 /10 十秒一圈
    self.rotateImage.transform = CGAffineTransformRotate(self.rotateImage.transform, 2 * M_PI / 60 / 8);
}


- (IBAction)pickNumber:(id)sender {
    
    if(![self.rotateImage.layer animationForKey:@"key"])
{
    //停止转盘自转
    self.link.paused = YES;
    
    
    //核心动画--基本动画
    CABasicAnimation *anim = [[CABasicAnimation alloc] init];
    //修改的属性
    anim.keyPath = @"transform.rotation";
    //计算需要减去的角度
    CGFloat angle = 2 * M_PI / 12 * self.currentButton.tag;
    
    //设置圈数
    anim.toValue = @(5 * M_PI * 2 - angle);
    
    //设置时间
    anim.duration = 3;
    
    //默认核心动画会回到原来的位置
    //设置不 回到原来位置
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    [self.rotateImage.layer addAnimation:anim forKey:@"key"];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(anim.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //layer转了，控件没转,让控件转
        //layer动画结束，让控件转
        self.rotateImage.transform = CGAffineTransformMakeRotation(-angle);
        
        //设置弹窗    UIAlertAction
        [self.delegate showAlert];
        
        //移除核心动画
        //让其正常再次自转
        [self.rotateImage.layer removeAnimationForKey:@"key"];
        
    });
}
    
}

@end
