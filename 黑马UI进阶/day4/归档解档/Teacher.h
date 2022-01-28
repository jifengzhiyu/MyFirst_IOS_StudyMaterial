//
//  Teacher.h
//  归档解档
//
//  Created by 翟佳阳 on 2021/10/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Teacher : NSObject <NSCoding,NSSecureCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;


@end

NS_ASSUME_NONNULL_END
