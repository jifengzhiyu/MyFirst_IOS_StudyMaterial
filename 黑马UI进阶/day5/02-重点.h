// --- 关键方法

// 获取上下文
CGContextRef ctx = UIGraphicsGetCurrentContext();

// 创建可变路径(c)
CGMutablePathRef path = CGPathCreateMutable();

// 把路径放在上下文当中
CGContextAddPath(ctx, path);

// 创建路径对象(oc)
UIBezierPath* path = [UIBezierPath bezierPath];

// 渲染
CGContextStrokePath(ctx);

// --- 绘图的步骤

// 1.获取图形上下文

// 2.拼接路径 同时 添加到上下文当中

// 3.渲染

// --- 绘图的方式

// 5种

// 1.c 直接在上下文当中去拼接路径
// 2.c 先拼接路径 再把路径添加到上下文当中
// 3.c + oc 基本等同于第二种 把oc的path 转化成 CGPath
// 4.c + oc 把CGPath 转化成 oc的path
// 5.oc 声明path对象 拼接路径 渲染

// --- 关于drawrect

// 1.为什么代码要写在drawrect里面
// 因为只有在这个方法当中才能获取正确的上下文

// 2.drawrect方法中rect参数的含义是什么
// rect是当前view的bounds

// 3.drawrect什么时候调用
// 系统自动调用
// (1)当这个view第一次显示的时候调用
// (2)当重绘的时候调用

// 4.如何重绘
// view的setNeedsDisplay方法
// view的setNeedsDisplayInRect方法  rect参数是刷新指定的区域

// 5.为什么drawRect不要手动调用
// 因为系统调的时候是会确保创建view的上下文
// 手动调用的时候可能获取不到

// --- 绘图的样式
// 设置线宽
CGContextSetLineWidth(ctx, 20);
// 设置连接处的样式
CGContextSetLineJoin(ctx, kCGLineJoinRound);
// 设置头尾的样式
CGContextSetLineCap(ctx, kCGLineCapRound);

// 设置线的宽度
[path setLineWidth:30];

//       kCGLineJoinMiter, // 默认的效果
//       kCGLineJoinRound, // 圆角
//       kCGLineJoinBevel // 切角
// 设置连接处的样式
[path setLineJoinStyle:kCGLineJoinBevel];

//       kCGLineCapButt, // 默认
//       kCGLineCapRound, // 圆角
//       kCGLineCapSquare
// 设置头尾的样式
[path setLineCapStyle:kCGLineCapButt];

// --- 绘图的渲染的方式

// oc
[path stroke];
[path fill];

// c
// CGContextDrawPath(ctx, kCGPathStroke); <==> CGContextStrokePath(ctx);
// CGContextDrawPath(ctx, kCGPathFill); <==> CGContextFillPath(ctx);

// 既描边又填充
// c:
CGContextDrawPath(ctx, kCGPathFillStroke);
// oc: 两句话都执行
[path stroke];
[path fill];

// --- 奇偶填充规则

// c
CGContextDrawPath(ctx, kCGPathEOFill);

// oc
path.usesEvenOddFillRule = YES;

// 奇填偶不填

// --- 非零绕数

// 默认填充模式: nonzero winding number rule(非零绕数规则)从左到右跨过, +1。从右到左跨过, -1。最后如果为0, 那么不填充, 否则填充

// 验证 取区域中 任意一个点 拉一条射线 看图形与射线的交叉点 是从左往右还是从右往左

// --- 饼图

// 随机颜色
- (UIColor*)randomColor
{
    CGFloat r = arc4random() % 256 / 255.0;
    CGFloat g = arc4random() % 256 / 255.0;
    CGFloat b = arc4random() % 256 / 255.0;

    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

// 比较最小的值
MIN(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)

// 画扇形的时候 记得往圆心 连一条线
