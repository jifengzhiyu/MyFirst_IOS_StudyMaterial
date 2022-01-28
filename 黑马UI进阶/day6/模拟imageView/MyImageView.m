//
//  MyImageView.m
//  模拟imageView
//
//  Created by 翟佳阳 on 2021/10/5.
//

#import "MyImageView.h"

@implementation MyImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self.image drawInRect:rect];
    
}

- (void)setImage:(UIImage *)image{
    _image = image;
    //重绘
    [self setNeedsDisplay];
}


- (instancetype)initWithImage: (UIImage *)image{
    self = [super initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    if(self){
        self.image = image;
    }
    return self;
    
}
@end
