//
//  Dog.h
//  构造方法
//
//  Created by 翟佳阳 on 2021/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject
@property NSString* name;
@property int age;
- (void)shout;
- (instancetype)initWithName:(NSString*)name andAge:(int)age;
@end

NS_ASSUME_NONNULL_END
