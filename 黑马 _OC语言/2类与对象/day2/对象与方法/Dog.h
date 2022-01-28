//
//  Dog.h
//  对象与方法
//
//  Created by 翟佳阳 on 2021/8/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject
{
@public
    NSString* _name;
    NSString* _color;
}

- (void)shout;
@end
NS_ASSUME_NONNULL_END
