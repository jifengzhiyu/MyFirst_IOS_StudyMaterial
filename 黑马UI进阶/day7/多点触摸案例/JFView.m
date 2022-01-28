//
//  JFView.m
//  多点触摸案例
//
//  Created by 翟佳阳 on 2021/10/6.
//

#import "JFView.h"
@interface JFView ()

@property (nonatomic, strong) NSArray *images;



@end



@implementation JFView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSArray *)images{
    if(!_images){
        _images = @[[UIImage imageNamed:@"43"] , [UIImage imageNamed:@"44"]];
    }
    return _images;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //touches有几个对象，就有几个手指在触摸
    //NSLog(@"%ld",touches.count);
    
    [self addSpark:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self addSpark:touches];
     
}

- (void) addSpark:(NSSet *)touches{
    
    int i = 0;
    for (UITouch *t in touches) {
        
//    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:t.view];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.images[i]];
    imageView.center = p;
    [self addSubview:imageView];
    
    //动画
    [UIView animateWithDuration:2 animations:^{
        imageView.alpha = 0;
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
        }];
        i++;
    }
}

@end
