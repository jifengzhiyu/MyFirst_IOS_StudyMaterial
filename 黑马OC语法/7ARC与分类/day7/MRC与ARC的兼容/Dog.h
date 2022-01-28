//
//  Dog.h
//  MRC与ARC的兼容
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject
@property(nonatomic,strong)NSString* color;
@property(nonatomic,assign)int age;
@end

NS_ASSUME_NONNULL_END
