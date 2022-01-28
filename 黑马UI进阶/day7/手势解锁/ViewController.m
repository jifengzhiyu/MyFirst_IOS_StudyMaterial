//
//  ViewController.m
//  手势解锁
//
//  Created by 翟佳阳 on 2021/10/6.
//

#import "ViewController.h"
#import "JFView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet JFView *passwordView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //将图片 转化成背景（平铺方式
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"Home_refresh_bg"]];
    
    //密码
    //设置block内容
    self.passwordView.passwordBlock = ^(NSString *pwd){
        if([pwd isEqualToString:@"012"]){
            NSLog(@"正确");
            return YES;
        }else{
            NSLog(@"错误");
            return NO;
        }
    };
    
    
}


@end
