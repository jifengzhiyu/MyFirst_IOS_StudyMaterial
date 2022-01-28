//
//  Person.h
//  @Class
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import <Foundation/Foundation.h>
@class Book;
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property(nonatomic,retain)NSString* name;
@property(nonatomic,retain) Book *book;
- (void)dealloc;
- (void)read;
@end

NS_ASSUME_NONNULL_END
