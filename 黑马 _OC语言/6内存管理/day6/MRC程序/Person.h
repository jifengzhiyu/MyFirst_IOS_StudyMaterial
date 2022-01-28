//
//  Person.h
//  MRC程序
//
//  Created by 翟佳阳 on 2021/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property NSString* name;
@property int age;
- (void)sayHi;
- (void)dealloc;
//代表对象被回收了

@end

NS_ASSUME_NONNULL_END
