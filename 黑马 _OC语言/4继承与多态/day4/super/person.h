//
//  person.h
//  super
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    NSString* _name;
    int _age;
}
- (void)sayHi;
+ (void)hehe;
@end

NS_ASSUME_NONNULL_END
