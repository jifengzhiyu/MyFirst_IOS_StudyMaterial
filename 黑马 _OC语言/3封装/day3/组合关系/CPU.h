//
//  CPU.h
//  对象之间的关系
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPU : NSObject
{
    NSString* _brand;
    NSString* _model;
    int _zhengJiaoShu;
}

- (void)jisuan;
@end

NS_ASSUME_NONNULL_END
