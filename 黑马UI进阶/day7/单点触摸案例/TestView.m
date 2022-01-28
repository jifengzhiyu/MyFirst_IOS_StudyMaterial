//
//  TestView.m
//  单点触摸案例
//
//  Created by 翟佳阳 on 2021/10/6.
//

#import "TestView.h"

@implementation TestView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:self.superview];
    //让testView的中心 等于手指的位置
    self.center = p;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:self.superview];
    //让testView的中心 等于 手指最新的位置
    //法1:self.center = p;
    
    //法2
    CGPoint lastP = [t previousLocationInView:self.superview];
    //计算偏移量
    //该方法坐标系可以是 self(因为只以偏移量为主
    CGFloat offsetX = p.x - lastP.x;
    CGFloat offsetY = p.y - lastP.y;
    
    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
}

@end
