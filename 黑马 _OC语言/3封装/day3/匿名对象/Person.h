//
//  Person.h
//  匿名对象
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    @public
    NSString* _name;
    int _age;
}

- (void)sayHi;
@end

NS_ASSUME_NONNULL_END
