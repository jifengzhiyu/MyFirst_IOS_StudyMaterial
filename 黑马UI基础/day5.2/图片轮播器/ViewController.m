//
//  ViewController.m
//  图片轮播器
//
//  Created by 翟佳阳 on 2021/9/10.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
//为了让计时器可以随处访问，创建一个用来禁用计时器对象的属性
@property(nonatomic,strong)NSTimer * timer;

@end

@implementation ViewController
//实现即将开始拖拽的方法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //停止计时器，一旦停止计时器，该计时器就废了，下次必须重新创建一个新的计时器对象
    [self.timer invalidate];
    //该计时器已经废了，所以赋值nil
    self.timer = nil;
}

//实现拖拽完毕的方法
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//重新启用计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    //为了使下方UITextView也能同时滚动，需要修改self.timer的优先级和UITextView一样
    //获取当前的消息循环对象,管理发射消息的
    NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
    //改变优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

//实现UIScrollView的滚动方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //1、获取滚动x方向的偏移值
    CGFloat offsetX = scrollView.contentOffset.x;
    //为了实现移动半页就自动切换第二页的指示器
    offsetX += scrollView.frame.size.width * 0.5;
    //2、 计算当前页数（索引）
    int page = offsetX / scrollView.frame.size.width;
    //3、将页码设置给UIPageControl
    self.pageControl.currentPage = page;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //动态创建UIImageView添加到ScrollView里面
    CGFloat imgW = 300;
    CGFloat imgH = 130;
    CGFloat imgY = 0;
    
    for(int i = 0; i < 5; i++){
        //创建一个UIImageView
        UIImageView * imgView = [[UIImageView alloc] init];
        //设置图片,横向排列
        NSString * imgName = [NSString stringWithFormat:@"%d",i];
        imgView.image = [UIImage imageNamed:imgName];
        //计算每一个UIImageView再UIScrollView的X坐标
        CGFloat imgX = i * imgW;
        //设置frame
        imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        //把imgView添加到UIScrollView中
        [self.scrollView addSubview:imgView];
    }
    //设置UIScrollView的contentSize
    CGFloat maxW = self.scrollView.frame.size.width * 5;
    self.scrollView.contentSize = CGSizeMake(maxW, 0);
    
    //实现UIScrollView的分页效果
    //根据UIScrollView的宽度分页
    self.scrollView.pagingEnabled = YES;
    
    //隐藏水平滚动指示器
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    //指定UIPageControl的总页数
    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPage = 0;
    
    [self.view bringSubviewToFront:_pageControl];
    
    //创建一个计时器控制NSTimer控件
     self.timer =  [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    //每隔一秒钟执行哪个对象的哪个方法，创建之后自动启动
    
    //为了使下方UITextView也能同时滚动，需要修改self.timer的优先级和UITextView一样
    //获取当前的消息循环对象,管理发射消息的
    NSRunLoop * runLoop = [NSRunLoop currentRunLoop];
    //改变优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

//自动滚动图片,每隔3秒钟滚动到下一页
//如果图片滚动到最后一页，让图片滚动到第一页
- (void)scrollImage{
    //1、获取当前UIPageControl的页码
    NSInteger page = self.pageControl.currentPage;
    //2、判断是否是最后一页，如果是设置页面0，不是，页码+1
    if(page == self.pageControl.numberOfPages - 1){
        page = 0;
    }else{
        page++;
    }
    //3、每页的宽度* （页码+1),计算下一页的contentOffset.x
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    //4、设置新的偏移值contentOffset
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
}

@end
