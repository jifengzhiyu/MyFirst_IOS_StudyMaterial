//
//  Person.h
//  上帝和人的故事
//
//  Created by 翟佳阳 on 2021/8/3.
//

#import <Foundation/Foundation.h>
#import "Gender.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    @public
    NSString* _name;
    int _age;
    Gender _gender;
    int _leftLife;
}
- (void)show;
@end

NS_ASSUME_NONNULL_END
