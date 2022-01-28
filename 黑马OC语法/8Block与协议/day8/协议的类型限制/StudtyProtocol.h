//
//  StudtyProtocol.h
//  协议的类型限制
//
//  Created by 翟佳阳 on 2021/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol StudtyProtocol <NSObject>
- (void)study;
-(void)writeCode;
@end

NS_ASSUME_NONNULL_END
