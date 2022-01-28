//
//  JFView.m
//  单点触摸案例
//
//  Created by 翟佳阳 on 2021/10/6.
//

#import "JFView.h"
#import "TestView.h"
@interface JFView ()
@property (weak, nonatomic) IBOutlet TestView *testView;

@end


@implementation JFView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:t.view];
    CGPoint lastP = [t previousLocationInView:t.view];
    
    //计算偏移量
    CGFloat offSetX = p.x - lastP.x;
    CGFloat offsetY = p.y - lastP.y;
    
//    self.testView.center = CGPointMake(self.testView.center.x + offSetX, self.testView.center.y + offsetY);
    self.testView.center = CGPointMake(self.testView.center.x + offSetX, self.testView.center.y);

}


@end
