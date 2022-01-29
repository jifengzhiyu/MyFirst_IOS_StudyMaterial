//
//  ViewController.m
//  day2
//
//  Created by 翟佳阳 on 2021/8/30.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtQQ;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)login;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)login {
    //拿到用户名和密码
    NSString * qq = self.txtQQ.text;
    NSString * pwd = self.txtPassword.text;
    NSLog(@"QQ:%@,密码:%@",qq,pwd);
    
    //退出编辑
    [self.view endEditing:YES];
}

@end
