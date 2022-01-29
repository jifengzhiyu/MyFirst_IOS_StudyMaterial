//
//  Person.h
//  循环retain
//
//  Created by 翟佳阳 on 2021/8/13.
//

#import <Foundation/Foundation.h>
#import "Book.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property(nonatomic,retain)NSString * name;
@property(nonatomic,assign)Book *book;
- (void)read;

@end

NS_ASSUME_NONNULL_END
