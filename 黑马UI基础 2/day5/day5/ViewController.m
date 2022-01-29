//
//  ViewController.m
//  day5
//
//  Created by 翟佳阳 on 2021/9/9.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any  additional setup after loading the view.
    //告诉UIScrollView里面内容的实际大小
//    self.scrollView.contentSize = self.imgView.frame.size;
    //二选一
    self.scrollView.contentSize = self.imgView.image.size;
//设置UIScrollView内容的大小等于图片框的大小
    
    //隐藏滚动指示器
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    //设置UIScrollView内容的内边距
    self.scrollView.contentInset = UIEdgeInsetsMake(100, 50, 30, 5);
}

//通过代码让图片滚动
- (IBAction)scroll {
    //结构体不能直接修改值
    CGPoint point = self.scrollView.contentOffset;
    point.x += 150;
    point.y += 150;
//    self.scrollView.contentOffset = point;
    //动画效果
//    [UIView animateWithDuration:1.0 animations:^{
//            self.scrollView.contentOffset = point;
//    }];
    //相当于setter，那么我们使用一个带动画效果的setter
    [self.scrollView setContentOffset:point animated:YES];
    
}


@end
