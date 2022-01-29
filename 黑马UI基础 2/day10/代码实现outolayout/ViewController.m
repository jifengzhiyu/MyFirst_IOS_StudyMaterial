//
//  ViewController.m
//  代码实现outolayout
//
//  Created by 翟佳阳 on 2021/9/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建蓝色view
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    //blueView.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:blueView];
    
    //创建红色view
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    //redView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:redView];
    
    //禁用outoresizing
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //创建并添加约束
    //蓝色view
    
    //1、1创建蓝色view高度(50)的约束
    //该约束与其他控件无关，所以其中两个参数写成 nil NSLayoutAttributeNotAnAttribute
    NSLayoutConstraint *blueHC = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
    //把约束添加到空间上
    [blueView addConstraint:blueHC];
    
    //1、2距离左边30
    NSLayoutConstraint *blueLeft = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:blueView.superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:30];
    //1、3距离上边30
    NSLayoutConstraint *blueTop = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blueView.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:30];
   
    //1、4距离右边30
    NSLayoutConstraint *blueRight = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:blueView.superview attribute:NSLayoutAttributeRight multiplier:1.0 constant:-30];
    //该控件相对于父控件的距离，该控件相对于父控件往左边，所以是-30
    //添加到父控件里
    [self.view addConstraint:blueLeft];
    [self.view addConstraint:blueTop];
    [self.view addConstraint:blueRight];
    
    
    //红色view
    //2、1让红色view的高度等于蓝色view
    //控件与空间的属性相等，最后将该约束添加到共同的父控件中
    NSLayoutConstraint *redHC = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [self.view addConstraint:redHC];
    //2、2让红色view的top距离蓝色view的底部30
    NSLayoutConstraint *redTop = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30];
    [self.view addConstraint:redTop];
    //2、3两个右对齐
    NSLayoutConstraint *redRight = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraint:redRight];
    //2、4红色view的宽度等于蓝色view的0.5倍
    NSLayoutConstraint *redWidth = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0];
    [self.view addConstraint:redWidth];
    
}


@end
