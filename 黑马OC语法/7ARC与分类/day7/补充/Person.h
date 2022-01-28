//
//  Person.h
//  补充
//
//  Created by 翟佳阳 on 2021/8/16.
//

#import <Foundation/Foundation.h>
#import "Car.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property(nonatomic,retain)Car * car;
-(instancetype)initWithCar:(Car*)car;
@end

NS_ASSUME_NONNULL_END
