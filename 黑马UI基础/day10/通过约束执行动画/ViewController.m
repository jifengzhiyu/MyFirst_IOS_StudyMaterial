//
//  ViewController.m
//  通过约束执行动画
//
//  Created by 翟佳阳 on 2021/9/23.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *myView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btnClick{
    self.viewTopConstraint.constant += 100;

    [UIView animateWithDuration:2.0 animations:^{
    [self.view layoutIfNeeded];
        //如果有需要重新布局，调用父类方法
    }];
    
    
    
//    [UIView animateWithDuration:5.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.viewTopConstraint.constant += 100;
//        [self.myView layoutIfNeeded];
//    } completion:nil];
    
}

@end
