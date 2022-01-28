//
//  MyProtocol.h
//  protocol协议
//
//  Created by 翟佳阳 on 2021/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MyProtocol <NSObject>
- (void)run;
- (void)sleep;
@end

NS_ASSUME_NONNULL_END
