#pragma mark - 一. 音频

#pragma mark 1. 音效 (理解)
/**
 1. 导入AVFoundation框架
 2. 创建音效文件
 3. 播放音效文件
 
 音效: 非常短的音乐, 一般来说30秒以内的声音, 都算作音效
 */
一. 简单实用
1. 创建URL地址
2. 系统音效文件 SystemSoundID = UInt32
3. 创建音效文件 --> URL写完之后,需要转换成CF框架
4. 播放音效文件
    4.1 不带振动的播放
    4.2 带振动的播放 --> 真机才有效果
5. 如果不需要播放了, 需要释放音效所占用的内存

二. 工具类的封装
进行缓存字典的设置
1. 生成一个static缓存字典
2. 在initialize方法中进行缓存字典初始化
3. 工具方法
    1. 获取URL的字符串
    2. 从缓存字典中根据URL来取soundID 系统音效文件
    3. 判断soundID是否为0, 如果为0, 说明没有找到, 需要创建并设置到缓存字典中
4. 播放音效的公用方法抽取

三. 清空音效内存
1. 工具类中
    1. 遍历字典
    2. 清空音效文件的内存
2. 清空全局的音效文件应该在AppDelegate进行
3. 清空局部音效需要在当前控制器中释放

#pragma mark 2. 音乐 (掌握)
/**
 1. 需要使用AVFoundatiaon框架
 2. 创建音乐播放器
 3. 根据需求, 进行播放/暂停/停止
 */
一. 创建音乐播放器
1. 获取URL路径
2. 创建一个error对象 --> 为了将来出错方便处理
3. 创建音乐播放器

二. 播放/暂停/停止
1. 按照单词自己写方法即可
2. 暂停和停止表面上没有任何区别, 所以需要真正停止的, 需要将时间进行归零操作


#pragma mark 3. 录音 (理解)
/**
 1. 需要使用AVFoundatiaon框架
 2. 创建录音对象
 3. 根据需求, 进行录音/暂停/停止
 */
一. 创建录音器
1. 获取URL地址 --> 具体的文件名路径, 这里是指要将录音存放到哪里
2. 将path字符串转换成NSURL --> file://
3. 配置设置字典 , 录音参数, 我们可以不用在意参数的意义, 到时候根据公司的文档来设置即可
4. 创建Error对象 __autoreleasing 可以不加, 加上之后是最标准写法
5. 创建录音对象

二. 播放/暂停/停止
1. 按照单词自己写方法即可
2. 录制完毕, 可以到目录中查看

三. 注意事项
1. 如果同一路径再次录音, 则会覆盖之前的文件
2. 如果用户只是暂停了, 应该提示用户进行保存操作
3. 之后停止录音时, 最终的录音文件才会生产

四. 自动停止录音
1. 打开分贝的检测
2. 在录音的方法中进行分贝的循环检测 --> 添加计时器
    2.1 如果没有displayLink就创建
        2.1.1 创建displayLink
        2.1.2 添加到运行循环中
    2.2 判断如果暂停了循环, 就打开
3. 暂停录音及停止录音中, 需要停止循环
4. 循环调用的方法 根据分贝的大小来判断
    4.1. 更新分贝信息
    4.2. 获取分贝信息 --> iOS直接传0
    4.3. 实现2S自动停止
        4.3.1 先判断用户是否小于某个分贝值 --> 用户是否没说话
        4.3.2 如果发现很安静, 我们就可以记录一下, number进行叠加
        4.3.3 如果发现120次了, 都小于设定的分贝值
        4.3.4 调用停止方法

五. 真机使用注意
1. 在手机上运行时, 会提示授权麦克风
2. 自动停止录音不好使, 全部都是120. 如果要在真机运行, 还需要一个session类, 并且制定分类为录音


#pragma mark - 二. 视频

#pragma mark 1. 视频播放 (掌握)
一.  带View的播放器
1. 获取URL地址
2. 创建带View的播放器
3. 模态视图弹出 --> 模态视图的切换应该在View完全展示之后进行

二. 不带View的播放器
1. 获取URL地址
2. 创建带View的播放器
3. 设置view.frame --> 设置约束
4. 添加到view上
5*. 准备播放 --> 规范写法, 要写上. 调用play方法时, 会自动调用此方法
6. 开始播放
7. 控制模式

三. 监听播放结束 --> 移除view/连续播放
1. 注册通知监测视频播放完毕: moviePlayerPlaybackDidFinishNotification
2. 获取通知结束的状态
3. 根据状态不同来自行填写逻辑代码
    3.1 要想换视频, 就需要更换地址
    3.2. 调用play方法

四. iOS9中的视频播放
iOS9中, 需要2个框架AVKit / AVFoundation
1. 获取URL地址
2. AV播放视图控制器
3. 创建player --> 设置时需要传入网址
4. 开始播放

5. 模态弹出 --> 应该在视图出现之后调用
5. 如果想要自定义播放器的大小,应该自定义 --> 设置frame / 添加到视图中

#pragma mark 2. 视频截图 (理解)
1. 获取URL地址
2. 获取资源 AVAsset
3. 创建 资源图像生成器
4. 开始生成图像 --> CMTime
5. 主线程中更新UI

#pragma mark 3. 视频录制 (理解)
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AssetsLibrary/AssetsLibrary.h>

一. 创建UIImagePickerController
1. 其他步骤跟普通的选取图像一样
2. 设置媒体类型kUTTypeMovie -->MobileCoreServices
3. 设置相机检测模式
4. 设置视频的质量

3.4 步可以不写

二. 播放视频及保存视频

1. 获取媒体类型
2. 判断是否是视频的媒体类型
3. 如果是视频的媒体类型 --> 播放视频
4. 保存视频 --> AssetsLibrary
4.1 创建ALAssetsLibrary对象
4.2 调用writeVideoAtPathToSavedPhotosAlbum即可

ALAssetsLibrary已经过期, iOS9 需要换成 PHPhotoLibrary


#pragma mark 4. 视频压缩 (了解)
1. 创建步骤跟普通的选取图像一样
2. 设置媒体类型 才可以方便找到视频
3. 在代理方法中进行压缩
    1. 获取资源 --> AVFoundation
    2. 根据资源, 创建资源导出会话对象
    3. 设置导出路径
    4. 设置导出类型
    5. 开始导出





#pragma mark - 三. iOS9新特性补充
1. Nullability 为空性标记
* Xcode6.3时推出的
* 类似swift的?和!, 可为空:__nullable / nullable, 不能为空:__nonnull / nonnull
* 意义: 看到nullable, 就进行判空处理
* 大部分都为nonnull, 有宏定义方便使用:NS_ASSUME_NONNULL_BEGIN 和 NS_ASSUME_NONNULL_END
* 编译器层面- 没有改变系统的底层, 类似ARC-编译期

2. Lightweight Generics 轻量级泛型
* 可以指定容器类中对象的类型了
NSArray<NSString *> *strings = @[@"dong", @“peng”];
NSDictionary<NSString *, NSNumber *> *mapping = @{@"a": @1, @"b": @2};

*  意义: 不用多想就清楚下面的数组中存的是什么，避免了跳转头文件及类型使用错误混乱。

* 纯编译器的语法支持（llvm 7.0），和 Nullability 一样，没有借助任何 objc runtime 的升级，也就是说，这个新语法在 Xcode 7 上可以使用且完全向下兼容（更低的 iOS 版本）

三. __kindof
1. 既明确表明了返回值，又让使用者不必写强转。
- (__kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;


范例: 使用时前面基本会使用 UITableViewCell 子类型的指针来接收返回值，所以这个 API 为了让开发者不必每次都蛋疼的写显式强转，把返回值定义成了 id 类型，

而这个 API 实际上的意思是返回一个 UITableViewCell 或 UITableViewCell 子类的实例

2. 再举个带泛型的例子，UIView 的 subviews 属性被修改成了：
@property (nonatomic, readonly, copy) NSArray<__kindof UIView *> *subviews;

这样，写下面的代码时就没有任何警告了：
UIButton *button = (UIButton *)view.subviews.lastObject;

二. SafariServices
如果公司没有特殊的界面制定要求, 当弹出网页的时候, 可以使用这里的SFSafariViewController

三. UI 测试
创建项目的时候勾选 UI Tests
//1. 鼠标放到这里
//2. 点击下方红色录制按钮
//3. 停止时再次点击红色按钮


//录音
//    //settings  设置参数  录音相关参数  声道  速率  采样率
//    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
//    // 音频格式
//    setting[AVFormatIDKey] = @(kAudioFormatAppleIMA4);
//    // 音频采样率
//    setting[AVSampleRateKey] = @(600.0);
//    // 音频通道数
//    setting[AVNumberOfChannelsKey] = @(1);
//    // 线性音频的位深度
//    setting[AVLinearPCMBitDepthKey] = @(8);