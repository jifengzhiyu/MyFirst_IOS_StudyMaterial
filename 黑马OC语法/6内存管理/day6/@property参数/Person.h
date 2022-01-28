//
//  Person.h
//  @property参数
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import <Foundation/Foundation.h>
#import "Car.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property(nonatomic,retain) Car *car;
@property(nonatomic,assign,getter=xxx,setter=xyz:)int age;
@property(nonatomic,assign,getter = isGoodPerson)BOOL goodPerson;
- (void)dealloc;
- (void)drive;
@end

NS_ASSUME_NONNULL_END
