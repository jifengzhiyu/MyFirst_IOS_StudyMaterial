//
//  AppView.m
//  day3
//
//  Created by 翟佳阳 on 2021/9/4.
//

#import "AppView.h"
#import "APP.h"
@interface AppView()
//类扩展
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIButton *btnDownload;
- (IBAction)btnDownloadClick:(UIButton *)sender;


@end
@implementation AppView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
 //重写modle属性的set方法,同时把modle数据给子控件
-(void)setModle:(APP *)modle
{
    //先赋值
    _modle = modle;
    
    //解析模型数据，把模型数据赋值给UIView中的各个子控件
    self.imgViewIcon.image = [UIImage imageNamed:modle.icon];
    self.lblName.text = modle.name;
}


+(instancetype)appView{
            //通过xib创建每个应用UIVeiw
           //通过动态加载xib文件创建里面的view
           //1.1)找到xib所在应用的根目录
           NSBundle * rootBundle = [NSBundle mainBundle];
           //NSLog(@"%@",[mainBundle bundlePath]);
           //1.2)在根目录里面找到xib文件并加载
    return [[rootBundle loadNibNamed:@"AppView" owner:nil options:nil] lastObject];
           //loadNibNamed。。。方法返回值是NSArray,里面参数不用写xib后缀（本来就是专门针对xib）
           //lastObject返回值id
}


- (IBAction)btnDownloadClick:(UIButton *)sender {
    //1、禁用当前被点击的按钮
    sender.enabled = NO;
    //2、弹出一个消息提醒框，一个UILabel
    UILabel * lblMsg = [[UILabel alloc] init];
    //2.1设置文字
    lblMsg.text = @"正在下载。。。。。";
    //2.2设置背景颜色
    lblMsg.backgroundColor = [UIColor blackColor];
    //2.3设置frame
    CGFloat viewW = self.superview.frame.size.width;
    CGFloat viewH = self.superview.frame.size.height;
    
    CGFloat msgW = 200;
    CGFloat msgH = 30;
    CGFloat msgX = (viewW - msgW) / 2;
    CGFloat msgY = (viewH - msgH) / 2;
    lblMsg.frame = CGRectMake(msgX, msgY, msgW, msgH);
    
    //2.4设置文字颜色
    lblMsg.textColor = [UIColor redColor];
    //2.5文字居中显示
    lblMsg.textAlignment = NSTextAlignmentCenter;
    //3.6文字粗体
    lblMsg.font = [UIFont boldSystemFontOfSize:30];
    //3.7透明度
    lblMsg.alpha = 0.0;
    //0完全透明，1完全不透明
    
    //3.8设置圆角
    lblMsg.layer.cornerRadius = 20;
    lblMsg.layer.masksToBounds = YES;
    
    //3.9动画，一开始透明度是0，慢慢把透明度提高
    //开启一个动画，执行1.5秒
    [UIView animateWithDuration:1.5 animations:^{
        //把透明度变成0.6
        lblMsg.alpha = 0.6;
    } completion:^(BOOL finished) {
        //当透明度变大执行完毕之后执行下面代码
        //延时之后执行,匀速实现动画
        [UIView animateWithDuration:1.5 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            lblMsg.alpha = 0;
        } completion:^(BOOL finished) {
            if(finished){
                //把该lable从view中移除
                [lblMsg removeFromSuperview];
            }
        }];
    }];
    
    //3、把lable添加到控制器控制的大view上
    [self.superview addSubview:lblMsg];
    //这里self是AppView
}

@end
