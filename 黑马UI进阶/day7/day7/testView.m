 //
//  testView.m
//  day7
//
//  Created by 翟佳阳 on 2021/10/6.
//

#import "testView.h"

@implementation testView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
   // __func__是一个字符串，值为调用__func__函数的函数名。
    //获取触摸对象
    UITouch *t = touches.anyObject;
//    //点击次数
//    NSLog(@"%ld",t.tapCount);
//    //触摸的阶段
//    NSLog(@"%ld",t.phase);
//
//    //触摸对象view所在的window
//    NSLog(@"%@",t.window);
//    //当前view所在的window
//    NSLog(@"%@",self.window);
//
//    //触摸的view
//    NSLog(@"%@",t.view);
//    NSLog(@"%@",self);
    
    
    //以self为坐标系 返回所在的位置
//    CGPoint p = [t locationInView:self];
    //以self.superview为坐标系 返回所在的位置
    CGPoint p = [t locationInView:self.superview];
    NSLog(@"%@",NSStringFromCGPoint(p));
    
}
//手指离开
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //NSLog(@"%s",__func__);
    
    UITouch *t = touches.anyObject;
    
    //当前点的位置
    CGPoint p = [t locationInView:self];
    NSLog(@"当前 %@",NSStringFromCGPoint(p));
    //上一个点的位置
    CGPoint lastP = [t previousLocationInView:self];
    NSLog(@"上一个 %@",NSStringFromCGPoint(lastP));

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%s",__func__);

}

//非正常的离开（被其他消息打断
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);

    
}
@end
