//
//  Person.h
//  ARC机制下的循环引用
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import "Book.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property(nonatomic,strong)Book *book;
@end

NS_ASSUME_NONNULL_END
