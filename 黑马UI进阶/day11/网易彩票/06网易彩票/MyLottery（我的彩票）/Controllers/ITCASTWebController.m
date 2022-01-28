//
//  ITCASTWebController.m
//  06网易彩票
//
//  Created by teacher on 15/7/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTWebController.h"
#import "ITCASTHelp.h"

@interface ITCASTWebController () <UIWebViewDelegate>

@end

@implementation ITCASTWebController


- (void)loadView
{
    UIWebView *wbView = [[UIWebView alloc] init];
    //wbView.frame = [UIScreen mainScreen].bounds;
    self.view = wbView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor yellowColor];
    
    // 设置左侧的关闭按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(btnClose)];
    
    
    // 让当前的控制器的view中(WebView)中加载一个网页
    // 1. 获取web view
    UIWebView *wbView = (UIWebView *)self.view;
    wbView.delegate = self;
    
    // 2. 创建要加载的网址的url对象
    // 把一个互联网网址转换为一个NSUrl对象
    //NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    // 把一个本地的网页路径转换为一个NSUrl对象
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.help.html withExtension:nil];
    
    // 3. 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 4. 告诉UIWebView加载对应的请求对象
    [wbView loadRequest:request];
    
    
}

// 网页加载完毕以后执行的方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    // 创建要执行的js代码
    NSString *jsCode = [NSString stringWithFormat:@"document.location.href = '#%@';", self.help.ID];
    
    // 执行以上的JavaScript代码
    [webView stringByEvaluatingJavaScriptFromString:jsCode];
}



- (void)btnClose
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
