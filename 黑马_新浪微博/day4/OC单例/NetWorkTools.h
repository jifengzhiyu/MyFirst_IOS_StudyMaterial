//
//  NetWorkTools.h
//  OC单例
//
//  Created by 翟佳阳 on 2021/11/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
    应用场景：网络工具，音频工具
*/
@interface NetWorkTools : NSObject
/// 单例的全局访问点

+ (instancetype)sharedNetWorkTools;

@end

NS_ASSUME_NONNULL_END
