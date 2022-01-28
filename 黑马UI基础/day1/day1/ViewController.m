//
//  ViewController.m
//  day1
//
//  Created by 翟佳阳 on 2021/8/29.
//

#import "ViewController.h"

@interface ViewController ()
//第一个文本框

@property (weak, nonatomic) IBOutlet UITextField *text1;
//第二个文本框
@property (weak, nonatomic) IBOutlet UITextField *text2;
//运算完成显示
@property (weak, nonatomic) IBOutlet UILabel *result;

- (IBAction)CAL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)CAL {
    /*
     实现计算功能
     1、获取用户输入
     2、计算和
     3、显示结果到result上
     */
    // API
    NSString * num1 = self.text1.text;
    NSString * num2 = self.text2.text;
    
    int n1 = [num1 intValue];
    int n2 = [num2 intValue];
    //转换类型

    int result = n1 + n2;
    
    
    self.result.text = [NSString stringWithFormat:@"%d",result];
    
    //把键盘叫回去
//    [self.text1 resignFirstResponder];
//    [self.text2 resignFirstResponder];
    //法一
    
    [self.view endEditing:YES];
    //法2
}


@end
