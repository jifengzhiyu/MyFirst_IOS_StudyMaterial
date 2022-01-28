//
//  Book.h
//  循环retain
//
//  Created by 翟佳阳 on 2021/8/13.
//

#import <Foundation/Foundation.h>
@class Person;
NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)Person* owner;
- (void)castZhiShi;

@end

NS_ASSUME_NONNULL_END
