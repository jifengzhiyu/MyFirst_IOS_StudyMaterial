//
//  NetWorkTools.m
//  封装_AFN框架
//
//  Created by 翟佳阳 on 2021/11/26.
//

#import "NetWorkTools.h"

/// 网络工具协议
@protocol NetworkToolsProxy <NSObject>
//在第三方框架内部定义的方法（.h没有声明）想要使用需要这么做


/// 网络请求方法
///
/// @param method     HTTP 请求方法
/// @param URLString  URLString
/// @param parameters 参数字典
/// @param success    成功回调
/// @param failure    失败回调
///
/// @return NSURLSessionDataTask
@optional
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(nullable id)parameters
                                         headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                         failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

@end

/// 遵守网络协议 - 为了能够欺骗 Xcode 给一个智能提示，以及编译通过！
@interface NetWorkTools() <NetworkToolsProxy>
@end

@implementation NetWorkTools
+ (instancetype)sharedTools{
        static NetWorkTools *tools;
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            // 注意：末尾需要包含 '/'

            NSURL *baseURL = [NSURL URLWithString:@"http://httpbin.org/"];
            tools = [[self alloc] initWithBaseURL: baseURL];
            
            // 设置反序列化格式
            tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
            
        });
        return tools;
    }

///GETOrPOST
/// // dataTaskWithHTTPMethod本类没有实现方法，但是父类实现了
// 在调用方法的时候，如果本类没有提供，直接调用父类的方法，AFN 内部已经实现！
- (void)request:(JFRequestMethod *)method URLString:(NSString *)URLString parameters:(id)parameters finished:(void (^)(id result, NSError *error))finished{
    
    NSString *methodName = (method == GET) ? @"GET" : @"POST";
    
    [[self dataTaskWithHTTPMethod:methodName URLString:URLString parameters:parameters headers:nil uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
                finished(responseObject,nil);

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
                finished(nil,error);

            }] resume];
    
//    if(method == GET){
//    [self GET:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"%@",responseObject);
//        finished(responseObject,nil);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"%@",error);
//            finished(nil,error);
//        }];
//    }else{
//        //POST
//
//        [self POST:URLString parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"%@",responseObject);
//            finished(responseObject,nil);
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                NSLog(@"%@",error);
//                finished(nil,error);
//            }];
        
    //}
    
    
}


///中转类，自己再包装一层，让使用者看不见第三方框架
///get请求
- (void)request:(NSString *)URLString finished:(void (^)(id result, NSError *error))finished{
    
    [self GET:URLString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
        finished(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            finished(nil,error);
        }];
}

@end
