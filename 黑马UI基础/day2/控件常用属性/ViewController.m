//
//  ViewController.m
//  控件常用属性
//
//  Created by 翟佳阳 on 2021/9/1.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txt1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)show:(id)sender {
    
    //获取当前控制器管理view的所有子控件,遍历
//    for(UIView * view in self.view.subviews)
//    {
//        view.backgroundColor = [UIColor redColor];
//    }
    
    //改变文本框意外的背景颜色
//    self.txt1.superview.backgroundColor = [UIColor redColor];
    
    
   //通过tag访问控件
//    UITextField * txt = (UITextField*)[self.view viewWithTag:5];
//    txt.text = @"asasas";
    
    while(self.view.subviews.firstObject){
        [self.view.subviews.firstObject removeFromSuperview];
    }
    
}


@end
