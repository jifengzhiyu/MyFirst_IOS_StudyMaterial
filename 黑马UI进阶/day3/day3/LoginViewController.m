//
//  LoginViewController.m
//  day3
//
//  Created by 翟佳阳 on 2021/9/30.
//

#import "LoginViewController.h"
#import "ContactViewController.h"

#define KUsernameKey @"KUsernameKey"
#define KPasswordKey @"KPasswordKey"
#define KRemPasswordKey @"KRemPasswordKey"
#define KautoLoginKey @"KautoLoginKey"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UISwitch *remPassword;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.userNameField.delegate = self;
    // 监听文本框的文字，切换登录按钮的状态
    [self.userNameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    //监听登录按钮
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];

    //恢复上次开关状态
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.remPassword.on = [ud boolForKey:KRemPasswordKey];
    self.autoLogin.on = [ud boolForKey:KautoLoginKey];
    
    //回复用户名和密码
    self.userNameField.text = [ud objectForKey:KUsernameKey];
    if(self.remPassword.isOn){
    self.passwordField.text = [ud objectForKey:KPasswordKey];
    }
    
    if(self.autoLogin.isOn){
        [self login];
    }
    
    [self textChange];
}

//登录按钮的点击事件
//三秒延迟
- (void)login{
    //第三方
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if([self.userNameField.text isEqualToString:@"1"] && [self.passwordField.text isEqualToString:@"1"]){
            //手动segue,跳转
            [self performSegueWithIdentifier:@"login2contact" sender:nil];
            
            //使用偏好设置，保存状态
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setBool:self.remPassword.isOn forKey:KRemPasswordKey];
            [ud setBool:self.autoLogin.isOn forKey:KautoLoginKey];
            
            [ud setObject:self.userNameField.text forKey:KUsernameKey];
            [ud setObject:self.passwordField.text forKey:KPasswordKey];
            
            [ud synchronize];
            
        }
    });
   
}


//文本框发生变动时用
-(void)textChange{
    //NSLog(@"%@",self.userNameField.text);
//    if(self.userNameField.text.length > 0 && self.passwordField.text.length > 0){
//        self.loginButton.enabled = YES;
//    }else{
//        self.loginButton.enabled = NO;
//    }
    self.loginButton.enabled = self.userNameField.text.length > 0 && self.passwordField.text.length > 0;
}

#pragma mark - 文本框的代理方法
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//// return NO to disallow editing.
//    //第一个文本框不能编辑
//    return YES;
//}


//- (void)textFieldDidBeginEditing:(UITextField *)textField          // became first responder
//{
//    NSLog(@"textFieldDidBeginEditing");
//    NSLog(@"%@",self.userNameField.text);
//}


//是否结束编辑
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
//{
//    //NO 不允许结束编辑
//    return NO;
//}


//- (void)textFieldDidEndEditing:(UITextField *)textField             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
//{
//    NSLog(@"textFieldDidEndEditing");
//}

//是否允许文本框改变文字内容
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
//{
//    NSLog(@"%@",self.userNameField.text);
//    return YES;
//
//}





#pragma mark - Navigation
    //只要用storyboard都会调用
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ContactViewController *contact = segue.destinationViewController;
    contact.username = self.userNameField.text;
}

#pragma mark - switch的方法

- (IBAction)remPasswordChange:(UISwitch *)sender {
    //如果关闭记住密码，就关闭自动登录
    if(!sender.isOn){
//        self.autoLogin.on = NO;
        [self.autoLogin setOn:NO animated:YES];
    }
}
- (IBAction)autoLoginChange:(UISwitch *)sender {
    //如果关闭自动登录，就关闭记住密码
    if(sender.isOn){
//        self.remPassword.on = YES;
        [self.remPassword setOn:YES animated:YES];
    }
}
@end
