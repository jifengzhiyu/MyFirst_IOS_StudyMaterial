//
//  Person.h
//  id指针
//
//  Created by 翟佳阳 on 2021/8/9.
//

#import "Animal.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property NSString* name;
- (void)sayHi;
+(instancetype)person;
@end

NS_ASSUME_NONNULL_END
