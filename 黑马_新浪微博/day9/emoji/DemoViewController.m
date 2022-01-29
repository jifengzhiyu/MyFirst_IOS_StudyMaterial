//
//  DemoViewController.m
//  emoji
//
//  Created by 翟佳阳 on 2021/12/9.
//

#import "DemoViewController.h"
#import "emoji-Swift.h"
@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *str = @"0x1f609";
    NSLog(@"%@",[str emoji]);
    Test2 *test = [Test2 new];
    [test show];
    
    

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
