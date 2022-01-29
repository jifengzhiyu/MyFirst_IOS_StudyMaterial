//
//  ViewController.m
//  GCD
//
//  Created by 翟佳阳 on 2021/10/19.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"hi---%@",[NSThread currentThread]);
    });
    
}
@end
