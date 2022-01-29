
// --- 旋转缩放平移

// 对图形上下文进行旋转平移缩放的操作

// 缩放
// 第一个参数:需要缩放的上下文
// 第二个参数:x轴缩放的比例
// 第三个参数:y轴缩放的比例
CGContextScaleCTM(ctx, 1, 0.5);

// 平移
// 第一个参数:需要平移的上下文
// 第二个参数:x轴的偏移量
// 第三个参数:y轴的偏移量
CGContextTranslateCTM(ctx, 150, 150);

// 旋转
// 第一个参数:需要旋转的上下文
// 第二个参数:顺时针旋转的角度
CGContextRotateCTM(ctx, M_PI_4);

// --- 图形上下文栈

// 图形上下文栈 只是保存 状态信息(样式)

// 保存状态信息
CGContextSaveGState(ctx);

// 恢复状态信息
CGContextRestoreGState(ctx);

// --- quartz2d 内存管理
// 如果包含 create copy 关键字的时候 记得释放
// 释放 1
CGPathRelease(path);
// 释放 2
CFRelease(path);

// --- 绘制文字
// 绘制 - 从(0,0)点开始画
[str drawAtPoint:CGPointZero withAttributes:dict];

// 绘制 - 绘制到指定的区域
[str drawInRect:rect withAttributes:nil];

// AttributeName - key 在 UIKit下的 NSAttributeName.h 里面
// 个人建议 记其中一个

// shadow
NSShadow* s = [[NSShadow alloc] init];
s.shadowOffset = CGSizeMake(100, 100); // 偏移量
s.shadowBlurRadius = 0; // 越小越不模糊 高斯模糊
s.shadowColor = [UIColor yellowColor]; // 阴影的颜色

// --- 绘制图片
// 绘制 - 从某个点开始绘制
[image drawAtPoint:CGPointZero];
// 绘制 - 绘制到某一个区域
[image drawInRect:rect];
// 绘制 - 平铺
[image drawAsPatternInRect:rect]; // 可以考虑用来设置某个view的背景图片

// --- 裁剪上下文显示的区域
// 前提:画一个图形
// 裁剪图片
CGContextClip(ctx);

// 告诉系统 已这个图形来裁剪图片 渲染 然后显示出来
// 所谓裁剪并不是裁剪掉上下文 只是单纯的 裁剪出来希望显示的区域而已!!!

// --- bitmap上下文

// 创建上下文(图片)
UIGraphicsBeginImageContext(CGSizeMake(300, 300));
// 创建上下文 (大小,不透明,缩放:0)
UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), NO, 0);

// 关闭上下文
UIGraphicsEndImageContext();

//  通过图片的图形上下文获取图片
UIImage* image = UIGraphicsGetImageFromCurrentImageContext();

// 保存到沙盒当中
NSString* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
path = [path stringByAppendingPathComponent:@"xx.png"];
// 把image转化成 NSData类型
NSData* data = UIImagePNGRepresentation(image);
NSLog(@"%ld", data.length);
// 然后在通过data对象  write to file 来写入到沙盒中
[data writeToFile:path atomically:YES];

// --- 裁剪圆形图片
// 保存到相册
// 第一个:图片
// 第二个 第三个 监听   注意:@selector 不能随便写 使用"注释"当中的方法
// 第四个: 可以把它当做一个tag来使用 参数在监听的方法当中会传入
UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), @"hello1111");

// --- 屏幕截图
// 对控制器的view的layer属性 进行操作
[self.view.layer renderInContext:ctx];
