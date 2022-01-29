//
//  ViewController.m
//  02.1按钮使用进阶
//
//  Created by 翟佳阳 on 2021/8/29.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnIcon;
- (IBAction)move:(UIButton *)sender;
- (IBAction)scale:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



//上下左右移动
//给控件设置tag值，根据sender.tag判断用户当前点击的是哪个按钮
- (IBAction)move:(UIButton *)sender {
//通过frame控制位置
    //    {//1、获取原始frame
//    CGRect originFrame = self.btnIcon.frame;
//
//    //2、修改frame
//    switch (sender.tag) {
//        case 50:
//            //上
//            originFrame.origin.y -= 50;
//            break;
//
//        case 20:
//            //右
//            originFrame.origin.x += 50;
//            break;
//        case 30:
//            //下
//            originFrame.origin.y += 50;
//            break;
//        case 40:
//            //左
//            originFrame.origin.x -= 50;
//            break;
//        default:
//            break;
//    }
//
//    //3、重新赋值
//    self.btnIcon.frame = originFrame;
//    }
//通过center控制位置
    CGPoint centerPoint = self.btnIcon.center;
    switch (sender.tag) {
            case 10:
                //上
            centerPoint.y -= 50;
                break;
    
            case 20:
                //右
            centerPoint.x += 50;
                break;
            case 30:
                //下
            centerPoint.y += 50;
                break;
            case 40:
                //左
            centerPoint.x -= 50;
                break;
            default:
                break;
        }
//无动画效果
//self.btnIcon.center = centerPoint;
    
    
    //动画效果
    
    [UIView animateWithDuration:2 animations:^{
        self.btnIcon.center = centerPoint;
    }];
    
    
    
    
    
}

- (IBAction)scale:(UIButton *)sender
//通过frame修改大小
//{
//    CGRect originFrame = self.btnIcon.frame;
//
//    if(sender.tag == 500)
//    {
//        //缩小
//        originFrame.size.height -= 50;
//        originFrame.size.width -= 50;
//
//    }else
//    {
//        originFrame.size.height += 50;
//        originFrame.size.width += 50;
//    }
//
//    self.btnIcon.frame = originFrame;
//}

//通过bounds修改大小,以中心为缩放基准点
{
    CGRect originBounds = self.btnIcon.bounds;
    
    //NSLog(@"%@",NSStringFromCGRect(originBounds));
    //bounds只能改变大小,x,y都是0
    if(sender.tag == 200){
        originBounds.size.height += 50;
        originBounds.size.width += 50;
    }
    else
    {
        originBounds.size.height -=50;
        originBounds.size.width -= 50;
        
    }
    
//    self.btnIcon.bounds = originBounds;
    
    //动画效果
    [UIView animateWithDuration:2.0 animations:^{
        self.btnIcon.bounds = originBounds;
    }];
}
@end
