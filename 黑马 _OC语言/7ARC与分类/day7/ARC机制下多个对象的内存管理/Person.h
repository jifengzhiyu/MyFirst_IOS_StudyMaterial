//
//  Person.h
//  ARC机制下多个对象的内存管理
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import "Car.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
//{
//    __weak Car * _car;
//}
//- (void)setCar:(Car*)car;
//- (Car*)car;
@property(nonatomic,weak)Car * car;
@end

NS_ASSUME_NONNULL_END
