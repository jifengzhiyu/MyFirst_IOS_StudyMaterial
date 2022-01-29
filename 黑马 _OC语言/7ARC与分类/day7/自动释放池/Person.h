//
//  Person.h
//  自动释放池
//
//  Created by 翟佳阳 on 2021/8/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property(nonatomic,retain)NSString* name;
@property(nonatomic,assign)int age;
@end

NS_ASSUME_NONNULL_END
