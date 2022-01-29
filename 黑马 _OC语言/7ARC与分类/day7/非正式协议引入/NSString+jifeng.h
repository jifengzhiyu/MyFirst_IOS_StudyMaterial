//
//  NSString+jifeng.h
//  非正式协议引入
//
//  Created by 翟佳阳 on 2021/8/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (jifeng)
- (int)numberCount;
//求当前该字符串对象中有多少个阿拉伯数字，参数就是该对象，就不需要传参了
@end

NS_ASSUME_NONNULL_END
