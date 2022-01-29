//
//  ViewController.m
//  喜马拉雅
//
//  Created by 翟佳阳 on 2021/9/9.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *lastImgView;
@property (weak, nonatomic) IBOutlet UIView *frontView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSUInteger index1 = [self.view.subviews indexOfObject:_frontView];
//    NSUInteger index2 = [self.view.subviews indexOfObject:_scrollView];
//
//    [self.view exchangeSubviewAtIndex:index2 withSubviewAtIndex:index1];
    
    
    CGFloat maxH = CGRectGetMaxY(self.lastImgView.frame);
    self.scrollView.contentSize = CGSizeMake(0, maxH);
    //如果是0代表不希望滚动这里
    
    //设置默认滚动位置
    self.scrollView.contentOffset = CGPointMake(0, -74);
    //设置内边距
    self.scrollView.contentInset = UIEdgeInsetsMake(74, 0, 0, 0);
    /*
     需求：监听UIScrollView的滚动事件
     通过代理实现
     1、为UIScrollView找一个代理对象，即设置UIScrollView的delegate属性
     self.dcrollView.delegate = self;
     一般都使用控制器作为控件的代理对象
     
     2、为了保证代理对象有对应的方法，要让代理对象遵守对应控件的代理协议（这里UIScrollViewDelegate协议）
     
     3、实现对应方法
     */
    self.scrollView.delegate = self;
    
    [self.view bringSubviewToFront:_frontView];
}


//输出当前滚动的位置
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSString *pointStr = NSStringFromCGPoint(scrollView.contentOffset);
    NSLog(@"%@",pointStr);
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.view bringSubviewToFront:_frontView];
//}

@end
