//
//  ViewController.m
//  偏好设置
//
//  Created by 翟佳阳 on 2021/10/2.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)save_set:(id)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"value" forKey:@"key"];
    [ud setBool:YES forKey:@"isOn"];
    
    [ud synchronize];
    
}




- (IBAction)read_set:(id)sender {
    
    //获取ud单例对象
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[ud objectForKey:@"key"]);
    NSLog(@"%d",[ud boolForKey:@"isOn"]);
}









@end
