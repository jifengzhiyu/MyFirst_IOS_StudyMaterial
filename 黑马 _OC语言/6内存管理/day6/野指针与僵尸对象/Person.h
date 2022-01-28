//
//  Person.h
//  野指针与僵尸对象
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    @public
    NSString* name;
}

@property int age;
- (void)dealloc;
- (void)sayHi;

@end

NS_ASSUME_NONNULL_END
