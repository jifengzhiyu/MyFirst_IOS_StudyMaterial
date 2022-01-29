//
//  Person.h
//  NSMumber
//
//  Created by 翟佳阳 on 2021/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property(nonatomic,assign)int intValue;
- (instancetype)initWithIntValue:(int)value;
+ (instancetype)numberWithIntValue:(int)value;
@end

NS_ASSUME_NONNULL_END
