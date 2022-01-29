//
//  MyTools.h
//  单例
//
//  Created by 翟佳阳 on 2021/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTools : NSObject
+ (instancetype)sharedMyTools;
+ (instancetype)sharedMyToolsOnce;

@end

NS_ASSUME_NONNULL_END
