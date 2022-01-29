//
//  Person.h
//  延展
//
//  Created by 翟佳阳 on 2021/8/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property(nonatomic,strong)NSString* name;
@property(nonatomic,assign)int age;
- (void)sayHi;
@end

NS_ASSUME_NONNULL_END
