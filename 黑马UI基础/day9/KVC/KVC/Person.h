//
//  Person.h
//  KVC
//
//  Created by 翟佳阳 on 2021/9/21.
//

#import <Foundation/Foundation.h>
#import "Dog.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong)Dog *dog;
@property (nonatomic, assign) int age;
@property (nonatomic, copy) NSString *email;
@end

NS_ASSUME_NONNULL_END
