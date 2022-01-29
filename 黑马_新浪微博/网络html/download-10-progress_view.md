# 下载进度视图

## 属性

```objc
IB_DESIGNABLE
@interface ProgressButton : UIButton

@property (nonatomic, assign) IBInspectable float progress;
@property (nonatomic, strong) IBInspectable UIColor *lineColor;
@property (nonatomic, assign) IBInspectable CGFloat lineWidth;

@end
```

## 代码实现

```objc
@implementation ProgressButton

- (void)setProgress:(float)progress {
    _progress = progress;

    [self setTitle:[NSString stringWithFormat:@"%.02f%%", progress * 100] forState:UIControlStateNormal];

    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {

    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat r = (MIN(rect.size.width, rect.size.height) - self.lineWidth) * 0.5;
    CGFloat startAngle = - M_PI_2;
    CGFloat endAngle = self.progress * 2 * M_PI + startAngle;

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:r startAngle:startAngle endAngle:endAngle clockwise:YES];

    path.lineWidth = self.lineWidth;
    path.lineCapStyle = kCGLineCapRound;

    [self.lineColor setStroke];

    [path stroke];
}

@end
```

## Storyboard 技巧

在 SB 中直接设置自定义视图属性

