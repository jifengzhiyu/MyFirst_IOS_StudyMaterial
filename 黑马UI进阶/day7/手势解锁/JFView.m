//
//  JFView.m
//  手势解锁
//
//  Created by 翟佳阳 on 2021/10/6.
//

#define kButtonCount 9
#import "JFView.h"
@interface JFView ()
@property (nonatomic, strong) NSMutableArray *btns;

//需要连线的按钮
@property (nonatomic, strong) NSMutableArray *lineBtns;

@property (nonatomic, assign) CGPoint currentPoint;

@end
@implementation JFView

//懒加载需要连线的按钮
- (NSMutableArray *)lineBtns{
    if(!_lineBtns){
        _lineBtns = [NSMutableArray array];
    }
    return _lineBtns;
}

//懒加载按钮数组
- (NSMutableArray *)btns{
    if(!_btns){
        _btns = [NSMutableArray array];
    
    for (int i = 0; i < kButtonCount; i++) {
        UIButton *btn = [[UIButton alloc] init];
        
        //生成密码 tag
        btn.tag = i;
        
//        btn.backgroundColor = [UIColor redColor];
        
        //禁止用户交互：但是还可以在上级view到touchBegan
        [btn setUserInteractionEnabled:NO];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        //禁用后可以更改背景 状态
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateDisabled];
        
        [self addSubview:btn];
        //添加到数组
        [self.btns addObject:btn];
    }
    }
    return _btns;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:t.view];
    //找出手指在哪个按钮范围内
    for (int i = 0; i < self.btns.count; i++) {
        UIButton *btn = self.btns[i];
        if(CGRectContainsPoint(btn.frame, p)){
            btn.highlighted = YES;
            //添加到需要画线的数组
            [self.lineBtns addObject:btn];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:t.view];
    
    //赋值全局属性
    self.currentPoint = p;
    
    //    //找出手指在哪个按钮范围内
    for(int i = 0; i < self.btns.count; i++){
        UIButton *btn = _btns[i];
        if(CGRectContainsPoint(btn.frame, p)){
            btn.highlighted = YES;
            
            //不重复添加
            if(![self.lineBtns containsObject:btn]){
                //添加到需要画线的数组
                [self.lineBtns addObject:btn];
            }
            
        }
    }
    //重绘
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    for(int i = 0; i < self.btns.count; i++){
//        UIButton *btn = self.btns[i];
//        btn.highlighted = NO;
//    }
//
//    //清空所有的线
//    [self.lineBtns removeAllObjects];
//
//    //重绘
//    [self setNeedsDisplay];
    
    //修改最后手指的位置为需要连线的最后一个按钮的中心
    //解决最后多根线问题
    self.currentPoint = [[self.lineBtns lastObject] center];
    //重绘
    [self setNeedsDisplay];
    
    //把所有画线的btn都变成错误的样式（禁用
    for(int i = 0; i < self.lineBtns.count; i++){
        UIButton *btn = self.lineBtns[i];
        //下面两句缺一不可
        btn.highlighted = NO;
        btn.enabled = NO;
    }
    
    //拼接密码
    NSString *password = @"";
    for(int i = 0; i < self.lineBtns.count; i++){
        UIButton *btn = self.lineBtns[i];
        password = [password stringByAppendingString:[NSString stringWithFormat:@"%ld",btn.tag]];
    }
//    NSLog(@"%@",password);
    if(self.passwordBlock){
        //给block传值
        if(self.passwordBlock(password)){
            NSLog(@"ye");
        }else{
            NSLog(@"sorrrrr");
        }
    }
    
    //关闭人机交互
    [self setUserInteractionEnabled:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self clear];
        [self setUserInteractionEnabled:YES];
    });
    
}

//清空
- (void)clear{
    for(int i = 0; i < self.btns.count; i++){
        UIButton *btn = self.btns[i];
        btn.highlighted = NO;
        btn.enabled = YES;
    }
    
    //清空所有的线
    [self.lineBtns removeAllObjects];
    
    //重绘
    [self setNeedsDisplay];
}

//storyboard 也是xib
//- (void)awakeFromNib{
//    [super awakeFromNib];
//    for (int i = 0; i < kButtonCount; i++) {
//        UIButton *btn = [[UIButton alloc] init];
//        btn.backgroundColor = [UIColor redColor];
//        [self addSubview:btn];
//        //添加到数组
//        [self.btns addObject:btn];
//    }
//}

//计算九宫格
//addSubview会触发layoutSubviews
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = 74;
    CGFloat h = w;
    int colCount = 3;
    CGFloat margin = (self.frame.size.width - 3 * w) / 4;
    for (int i = 0; i < self.btns.count; i++) {
        CGFloat x = (i % colCount) * (margin + w) + margin;
        CGFloat y = (i / colCount) * (margin + w) + margin;
        [self.btns[i] setFrame:CGRectMake(x, y, w, h)];
    }
    
}

//画线
//第一次这个view调用的时候 调用该方法
- (void)drawRect:(CGRect)rect{
    
    //如果没有需要画线的 直接return
    if(!self.lineBtns.count){
        return;
    }
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for(int i = 0; i < self.lineBtns.count; i++){
        UIButton *btn = self.lineBtns[i];
        //如果是第一选中个按钮 设置画笔起点
        if(i == 0){
            [path moveToPoint:btn.center];
        }else{
            [path addLineToPoint:btn.center];
        }
    }
    
    //连线到手指的位置
    [path addLineToPoint:self.currentPoint];
    
    [[UIColor whiteColor] set];
    [path setLineWidth:10];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    
    [path stroke];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
