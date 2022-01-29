//
//  Student.h
//  分类
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
{
    @private//私有属性
    int _age;
}
@property(nonatomic,strong)NSString * name;
- (void)hehe;
-(void)sayHi;
@end

NS_ASSUME_NONNULL_END
