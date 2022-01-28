//
//  Dog.h
//  day3
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject
{
    @public
    NSString* _name;
    NSString* _color;
    int _age;
    
}

- (void) shout;

//判断当前狗的对象年龄是否比另外1条狗大
- (BOOL)compareAgeWithOtherDog:(Dog*)otherDog;
@end

NS_ASSUME_NONNULL_END
