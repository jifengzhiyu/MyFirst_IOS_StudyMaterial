//
//  ViewController.m
//  封装_AFN框架
//
//  Created by 翟佳阳 on 2021/11/26.
//

#import "ViewController.h"

#import "NetWorkTools.h"
/**
 AFN 最常见的网络请求错误
 
 1. 不支持的内容 status code == 200，需要修改反序列化的 NSSet
 2. status code == 405，对应的 URL 不支持 HTTP 请求方法
 */
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Request failed: method not allowed (405)
    //url不支持该类型的请求 get
    //post要给服务器提交数据 服务器才会返回数据
    
    
//    [[NetWorkTools sharedTools] request:GET URLString:@"post" parameters:@{@"name" : @"zhangsan", @"age" : @18} finished:^(id  _Nonnull result, NSError * _Nonnull error) {
//            NSLog(@"%@------------%@",result, error);
//
//    }];
    
    //post把paramete的数据通过表单的方式传递 form
    [[NetWorkTools sharedTools] request:POST URLString:@"post" parameters:@{@"name" : @"zhangsan", @"age" : @18} finished:^(id  _Nonnull result, NSError * _Nonnull error) {
            NSLog(@"%@------------%@",result, error);

    }];
    
    //打印    url = "http://httpbin.org/get?age=18&name=zhangsan";
//    [[NetWorkTools sharedTools] request:GET URLString:@"get" parameters:@{@"name" : @"zhangsan", @"age" : @18} finished:^(id  _Nonnull result, NSError * _Nonnull error) {
//            NSLog(@"%@------------%@",result, error);
//
//    }];
    
    
//    [[NetWorkTools sharedTools] request:@"data/sk/101010100.html" finished:^(id  _Nonnull result, NSError * _Nonnull error) {
//        NSLog(@"%@------------%@",result, error);
//    }];
    // parameters:(id)parameters
}


@end
