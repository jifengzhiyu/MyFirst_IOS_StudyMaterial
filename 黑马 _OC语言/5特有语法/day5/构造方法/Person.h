//
//  Person.h
//  构造方法
//
//  Created by 翟佳阳 on 2021/8/11.
//

#import <Foundation/Foundation.h>
#import "Dog.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property NSString* name;
@property int age;
@property float weight,height;
@property Dog* dog;
- (void)sayHi;
- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
