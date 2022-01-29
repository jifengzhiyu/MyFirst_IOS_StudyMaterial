//
//  ViewController.m
//  异步下载网络图片
//
//  Created by 翟佳阳 on 2021/10/18.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
//一般控件使用weak,这里使用strong,否则控件一创建就会自动销毁
//https://blog.csdn.net/qinqi376990311/article/details/52934040
//https://www.cnblogs.com/xiaobai51/p/5631681.html


@end

@implementation ViewController

//先于viewDidLoad执行
- (void)loadView{
    //属性要加载
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    self.view = self.scrollView;
    
    self.imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:self.imageView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(download) object:nil];
    [thread start];
    
}

- (void)download{
    //图片地址
    NSURL *url = [NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcomic.people.com.cn%2FNMediaFile%2F2014%2F0122%2FMAIN201401221050000161744426865.jpg&refer=http%3A%2F%2Fcomic.people.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1637201947&t=02ac75f2b80c04311a5a01db63b05b32"];
    //下载图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    
    //让主线程执行
    //bool YES：等待该方法执行完毕，再执行之后的代码
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
}

- (void)updateUI:(UIImage *)image{
    self.imageView.image = image;
    //让UIImage大小和图片大小一致
    [self.imageView sizeToFit];
    
    //显示scrollView的滚动范围
    self.scrollView.contentSize = image.size;
    
    NSLog(@"显示成功");
}

@end
