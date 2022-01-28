//
//  Person.h
//  自定义类实现对象的拷贝
//
//  Created by 翟佳阳 on 2021/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject <NSCopying>
@property(nonatomic,copy)NSString * name;
@property(nonatomic,assign)int age;
@end

NS_ASSUME_NONNULL_END
