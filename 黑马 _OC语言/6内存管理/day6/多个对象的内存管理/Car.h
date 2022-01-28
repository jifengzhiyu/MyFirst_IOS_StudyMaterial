//
//  Car.h
//  多个对象的内存管理
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Car : NSObject
{
    int _speed;
}
- (void)setSpeed:(int)speed;
- (int)speed;
- (void)run;
- (void)dealloc;
@end

NS_ASSUME_NONNULL_END
