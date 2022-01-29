//
//  Person.h
//  关联关系
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>
#import "Dog.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    NSString* _name;
    Dog* _dog;
}
@end

NS_ASSUME_NONNULL_END
