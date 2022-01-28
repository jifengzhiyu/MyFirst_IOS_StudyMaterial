//
//  Person.h
//  对象与方法
//
//  Created by 翟佳阳 on 2021/8/3.
//

#import <Foundation/Foundation.h>
#import "Dog.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    @public
    NSString* _name;
    int _age;
}
- (void) sayHi;
- (void) test: (Dog*)dog;
- (Dog*) test1;



@end

NS_ASSUME_NONNULL_END
