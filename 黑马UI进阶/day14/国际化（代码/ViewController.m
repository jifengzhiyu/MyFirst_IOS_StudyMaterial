//
//  ViewController.m
//  国际化（代码
//
//  Created by 翟佳阳 on 2021/10/16.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    //第二个参数 注释用
    NSString *title = NSLocalizedString(@"title", nil);
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = title;
    lbl.frame = CGRectMake(100, 100, 120, 120);
    [self.view addSubview:lbl];
    
}


@end
