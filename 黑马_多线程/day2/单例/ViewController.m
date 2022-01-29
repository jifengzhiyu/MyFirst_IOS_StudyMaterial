//
//  ViewController.m
//  单例
//
//  Created by 翟佳阳 on 2021/10/20.
//

#import "ViewController.h"
#import "MyTools.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    MyTools *t1 = [MyTools sharedMyToolsOnce];
//    MyTools *t2 = [MyTools sharedMyToolsOnce];
//    NSLog(@"%@",t1);
//    NSLog(@"%@",t2);

    [self demo1];
    [self demo2];
    
}

- (void)demo1{
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 9000; i++) {
        [MyTools sharedMyTools];
    }
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSLog(@"%f",end - start);
}

- (void)demo2{
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 9000; i++) {
        [MyTools sharedMyToolsOnce];
    }
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
    NSLog(@"%f--once",end - start);
}
@end
