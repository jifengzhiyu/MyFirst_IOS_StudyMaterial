//
//  Person.h
//  单例模式
//
//  Created by 翟佳阳 on 2021/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
+(instancetype)sharedPerson;
+(instancetype)defaultPerson;
@end

NS_ASSUME_NONNULL_END
