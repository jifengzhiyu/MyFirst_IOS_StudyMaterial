//
//  ViewController.m
//  User_agent
//
//  Created by 翟佳阳 on 2021/11/28.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIWebView *webView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[UIWebView alloc] init];
    self.webView.frame = self.view.bounds;
    [self.view addSubview:self.webView];
    
    //发起网络请求
    NSURL *url = [NSURL URLWithString:@"http://m.baidu.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //设置请求头 forHTTPHeaderField 告诉服务器额外的信息
    [request setValue:@"iPhone" forHTTPHeaderField:@"User-Agent"];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
        //baseURL:加载素材的网页服务器路径
                [self.webView loadHTMLString:html baseURL:url];
    }] resume];
    
}


@end
