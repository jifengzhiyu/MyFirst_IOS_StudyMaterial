//
//  Car.h
//  ARC机制下多个对象的内存管理
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Car : NSObject
@property(nonatomic,assign)int speed;
- (void)run;
@end

NS_ASSUME_NONNULL_END
