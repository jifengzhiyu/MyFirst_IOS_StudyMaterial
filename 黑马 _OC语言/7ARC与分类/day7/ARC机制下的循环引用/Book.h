//
//  Book.h
//  ARC机制下的循环引用
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>
@class Person;
NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject
//改成weak @property(nonatomic,strong)Person * owner;
@property(nonatomic,weak)Person * owner;
@end

NS_ASSUME_NONNULL_END
