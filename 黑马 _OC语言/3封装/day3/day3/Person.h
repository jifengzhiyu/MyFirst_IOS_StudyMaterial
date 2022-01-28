//
//  Person.h
//  day3
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Dog.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person1 : NSObject
{
@public
    NSString* _name;
    int _age;
}
- (void)LiuWithDog:(Dog*)dog;
+ (void)hehe;
+(Person1*)person;//要求这个类提供一个和类名同名的类方法
+(Person1*)personWithName:(NSString*)name andAge:(int)age;
@end

NS_ASSUME_NONNULL_END
