//
//  Person.h
//  @property
//
//  Created by 翟佳阳 on 2021/8/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    int  _age;
}
@property NSString* name;
@property int age;
@end

NS_ASSUME_NONNULL_END
