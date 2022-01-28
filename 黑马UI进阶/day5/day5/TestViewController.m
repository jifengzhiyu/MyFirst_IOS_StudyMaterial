//
//  TestViewController.m
//  day5
//
//  Created by 翟佳阳 on 2021/10/3.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //关闭
    //ViewController控制器负责关闭testViewController
    //在需要关闭的控制器里面写一下方法，系统会给ViewController发送消息，让ViewController关闭
    //谁负责显示，谁负责关闭
    [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"已经关闭");
    }];
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
