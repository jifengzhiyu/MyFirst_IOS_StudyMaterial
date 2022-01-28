//
//  self.h
//  self
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface self : NSObject
{
    @public
    NSString* _name;
    int _age;
}
- (void)sayHi;
- (void)hehe;
+ (void)sb;

+(void)dsd;
@end

NS_ASSUME_NONNULL_END
