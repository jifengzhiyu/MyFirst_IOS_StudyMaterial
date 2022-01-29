// --- layer的基本属性

// 设置layer边框
testView.layer.borderWidth = 10; // 边框的宽度
testView.layer.borderColor = [UIColor whiteColor].CGColor; // 边框的颜色

// 设置layer阴影
testView.layer.shadowColor = [UIColor blueColor].CGColor; // 颜色
testView.layer.shadowOffset = CGSizeMake(20, 20); // 偏移量
testView.layer.shadowOpacity = 0.7; // 透明度 默认为0,所以不会显示.
testView.layer.shadowRadius = 10; //圆角

// 设置layer圆角
testView.layer.cornerRadius = 50; // 设置layer的圆角半径
testView.layer.masksToBounds = YES; // 裁剪 设置头像的时候 记得加上

// bounds 大小
//    testView.layer.bounds = CGRectMake(0, 0, 200, 200);

// position 位置
//    testView.layer.position = CGPointMake(0, 0); // 默认的位置是view得center

// 设置内容 (__bridge id)把cg转化成id
testView.layer.contents = (__bridge id)([UIImage imageNamed:@"haoyuexing"].CGImage); // 图片

// --- 手动创建layer

// 禁止隐式动画
[CATransaction begin];
[CATransaction setDisableActions:YES];

[CATransaction commit];

// 可动画属性 = 直接设置这个属性 就能够出现隐式动画
// 控件的根layer是没有隐式动画 也就是说 直接改变控件的根layer的属性 是不能够有隐式动画的

// Animatable 可动画属性的标记

// --- layer的transfrom属性

// layer的transform 是一个 CATransform3D 类型的 多个z轴

// --- 时钟
// 注意添加layer的顺序

// 锚点  定位点
second.anchorPoint = CGPointMake(0.5, 0.8);

// 获取当前日历对象
NSCalendar* cal = [NSCalendar currentCalendar];
CGFloat second = [cal component:NSCalendarUnitSecond fromDate:date];

// 角度的计算

// --- 核心动画
// 核心动画结束后 会回到原来的位置
// 不希望回到原来的位置(fillMode,removedOnCompletion)
// 如果不设置removedOnCompletion那么fillMode不起作用

// --- 基本动画(CABasicAnimation)
// keyPath 需要修改的属性
// fromValue 从哪
// toValue 到哪
// byValue 累加到哪
// repeatCount 重复的次数
// duration 时间

// --- 关键帧动画(CAKeyframeAnimation)
// keyPath 需要修改的属性
// values 放关键帧的数组
// path 做动画的路径

// --- 组动画(CAAnimationGroup)
// animations 放各种动画的数组
// 设置比如时间和重复次数的时候 需要给这个 组动画进行设置

// --- 转场动画 (CATransition)
// type 动画类型
// subtype 方向

// sudo killall -9 com.apple.CoreSimulator.CoreSimulatorService && rm -rf ~/Library/Developer/CoreSimulator/Devices
