//
//  ViewController.m
//  url网站
//
//  Created by 翟佳阳 on 2021/10/16.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载网页
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

    //创建url对象
    NSURL *url = [NSURL URLWithString:@"http:www.baidu.com"];
    //NSURL *url = [[NSBundle mainBundle] URLForResource:@"group_record.html" withExtension:nil];

    //通过统一资源定位符 包装一个请求
    NSURLRequest *req = [NSURLRequest requestWithURL:url];

    //加载请求
    [webView loadRequest:req];
    
    [self.view addSubview:webView];

    
}


@end
  
