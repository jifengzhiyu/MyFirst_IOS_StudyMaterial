//
//  JFViewController.m
//  代码加载自定义控制器
//
//  Created by 翟佳阳 on 2021/9/28.
//

#import "JFViewController.h"

@interface JFViewController ()

@end

@implementation JFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];

    NSLog(@"viewDidLoad");
}

//加载
//一般在    [self.window makeKeyAndVisible]; 调用loadView
//要把window(继承UIView)显示出来
//实际在.view的时候调用

- (void)loadView{
    [super loadView];
    NSLog(@"loadView");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
