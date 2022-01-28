//
//  Person.h
//  多个对象的内存管理
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import <Foundation/Foundation.h>
#import "Car.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    Car* _car;
}
- (void)setCar:(Car*)car;
- (Car*)car;
- (void)drive;
- (void)dealloc;
@end

NS_ASSUME_NONNULL_END
