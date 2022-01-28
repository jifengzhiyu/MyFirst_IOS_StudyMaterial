//
//  ViewController.m
//  应用内的国际化（不依赖系统语言
//
//  Created by 翟佳阳 on 2021/10/16.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, copy) NSString *fileName;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //第二个参数 注释用
    NSString *title = NSLocalizedStringFromTable(@"title", self.fileName  , nil);
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = title;
    lbl.frame = CGRectMake(100, 100, 120, 120);
    [self.view addSubview:lbl];
}

- (IBAction)chClick:(id)sender {
    self.fileName = @"ch";
}

- (IBAction)enClick:(id)sender {
    self.fileName = @"en";

}
@end
