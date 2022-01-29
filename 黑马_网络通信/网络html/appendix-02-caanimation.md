# 核心动画

```objc
/**
 CAKeyframeAnimation    path/values
 CABasicAnimation       fromValue/toValue
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 1. 位移动画
    CAKeyframeAnimation *anim1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 250, 250)];
    anim1.path = path.CGPath;

    // 2. 旋转动画
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anim2.toValue = @(2 * M_PI);

    // 3. 缩放动画
    CAKeyframeAnimation *anim3 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    anim3.values = @[@1, @0.1, @1.2];

    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[anim1, anim2, anim3];
    group.duration = 2.0;
    group.repeatCount = MAXFLOAT;

    [self.myView.layer addAnimation:group forKey:nil];
}
```
