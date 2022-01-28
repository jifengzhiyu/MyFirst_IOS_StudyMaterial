//
//  ViewController.m
//  字符串存储plist
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
    
    NSString *str = @"value";
    NSString *tmpPath = NSTemporaryDirectory();
    NSString *filePath = [tmpPath stringByAppendingPathComponent:@"xxx.plist"];
    [str writeToFile:filePath atomically:YES encoding:NSASCIIStringEncoding error:nil];
    
}

//点击屏幕
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSString *tmpPath = NSTemporaryDirectory();
    NSString *filePath = [tmpPath stringByAppendingPathComponent:@"xxx.plist"];
    
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:nil];
    NSLog(@"%@",str);
    
}

@end
