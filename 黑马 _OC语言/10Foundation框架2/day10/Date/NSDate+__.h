//
//  NSDate+__.h
//  Date
//
//  Created by 翟佳阳 on 2021/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (__)
//分类，如果里面写@property，只能生成声明
@property(nonatomic,assign,readonly)int year;
@end

NS_ASSUME_NONNULL_END
