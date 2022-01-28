//
//  Person.h
//  对象作为类的属性
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "Dog.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    @public
    NSString* _name;
    int _age;
    Dog* _dog;
}

@end

NS_ASSUME_NONNULL_END
