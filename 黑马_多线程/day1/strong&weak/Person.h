//
//  Person.h
//  strong&weak
//
//  Created by 翟佳阳 on 2021/10/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic, copy) NSString *name;

+ (instancetype)personWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
