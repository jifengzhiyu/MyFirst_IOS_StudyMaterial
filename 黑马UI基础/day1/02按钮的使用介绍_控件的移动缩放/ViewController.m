//
//  ViewController.m
//  02按钮的使用介绍_控件的移动缩放
//
//  Created by 翟佳阳 on 2021/8/29.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)scale:(UIButton *)sender;
- (IBAction)down;
- (IBAction)scale:(UIButton *)sender;
- (IBAction)up;

- (IBAction)right;
- (IBAction)left;
- (IBAction)jian;
- (IBAction)jia;
@property (weak, nonatomic) IBOutlet UIButton *btnicon;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)up {
    //获取y值，使其递减，再赋值
    CGRect originFrame =self.btnicon.frame;
    //拿到原始坐标
    
    originFrame.origin.y -= 10;
    //origin坐标
    self.btnicon.frame = originFrame;
       
}

- (IBAction)scale:(UIButton *)sender {
}

- (IBAction)down {
    CGRect originFrame = self.btnicon.frame;
    //获取原始frame
    originFrame.origin.y += 10;
    //给frame赋值
    self.btnicon.frame = originFrame;
    //赋值给原始frame，相当于originFrame就是一个中介
}






- (IBAction)left {
    CGRect originFrame = self.btnicon.frame;
    originFrame.origin.x -= 10;
    self.btnicon.frame = originFrame;
}

- (IBAction)right {
    CGRect originFrame = self.btnicon.frame;
    originFrame.origin.x += 10;
    self.btnicon.frame = originFrame;
}


- (IBAction)jia {
    
    CGRect originFrame =self.btnicon.frame;
    
//    originFrame.size = CGSizeMake(originFrame.size.height + 10, originFrame.size.width + 10);
    //这样按两下才会出现放大一圈的效果
    //还是使用下面的方法好了
    
    
    originFrame.size.height += 10;
    originFrame.size.width +=10;
    self.btnicon.frame = originFrame;
}
//缩小
- (IBAction)jian {
    CGRect originFrame = self.btnicon.frame;
    
    originFrame.size.height -= 10;
    originFrame.size.width -= 10;
    
    self.btnicon.frame = originFrame;
}


@end
