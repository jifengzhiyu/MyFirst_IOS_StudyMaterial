//
//  Book.h
//  @Class
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import <Foundation/Foundation.h>
#import"Person.h"
NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject
@property(nonatomic,retain)NSString * name;
@property(nonatomic,retain)NSString * authorName;
@property(nonatomic,retain)Person * owner;
- (void)chuanboZhishi;
- (void)dealloc;
@end

NS_ASSUME_NONNULL_END
