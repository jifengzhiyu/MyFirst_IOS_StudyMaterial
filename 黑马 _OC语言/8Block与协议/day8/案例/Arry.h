//
//  Arry.h
//  案例
//
//  Created by 翟佳阳 on 2021/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Arry : NSObject
{
    int _arr[10];
}
//- (void)bianLi;
- (void)bianLiWithBlock:(void(^)(int val))processBlock;
@end

NS_ASSUME_NONNULL_END
