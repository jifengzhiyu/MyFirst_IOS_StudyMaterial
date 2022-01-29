//
//  ViewController.m
//  异步下载网络图片
//
//  Created by 翟佳阳 on 2021/10/19.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;




@end

@implementation ViewController

- (void)loadView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    self.view = self.scrollView;
    
    self.imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:self.imageView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //开启异步执行，下载网络图片
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [NSURL URLWithString:@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Falbum%2F0f59db0ae49200b41713d15d9b0682f6721c94d8.jpg&refer=http%3A%2F%2Fi0.hdslb.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1637248655&t=b6369ce0a08481b208d6805d3a2c713c"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        //回到主线程更新ui
        //同步
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            [self.imageView sizeToFit];
            self.scrollView.contentSize = image.size;
        });
    });
}


@end
