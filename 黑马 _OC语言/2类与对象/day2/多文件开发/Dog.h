//
//  Dog.h
//  多文件开发
//
//  Created by 翟佳阳 on 2021/8/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject
{
    @public
    NSString* _name;
    int _age;
}

- (void)sayHi;

@end

NS_ASSUME_NONNULL_END
