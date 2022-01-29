//
//  NetWorkTools.h
//  封装_AFN框架
//
//  Created by 翟佳阳 on 2021/11/26.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

/// 网络请求枚举
typedef enum : NSInteger {
    GET,
    POST,
} JFRequestMethod;



@interface NetWorkTools : AFHTTPSessionManager
+ (instancetype)sharedTools;

- (void)request:(JFRequestMethod *)method URLString:(NSString *)URLString parameters:(id)parameters finished:(void (^)(id result, NSError *error))finished;

- (void)request:(NSString *)URLString finished:(void (^)(id result, NSError *error))finished;
@end

NS_ASSUME_NONNULL_END
