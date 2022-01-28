//
//  Dog.h
//  对象作为类的属性
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "QuanQuan.h"

NS_ASSUME_NONNULL_BEGIN


@interface Dog : NSObject

{
    @public
    NSString* _name;
    NSString* _color;
    QuanQuan* _qq;
}

- (void)shout;

@end

NS_ASSUME_NONNULL_END
