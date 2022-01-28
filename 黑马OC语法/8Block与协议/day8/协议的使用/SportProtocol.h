//
//  SportProtocol.h
//  协议的使用
//
//  Created by 翟佳阳 on 2021/8/18.
//

#import <Foundation/Foundation.h>
#import "PlayProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@protocol SportProtocol <PlayProtocol>
- (void)paShan;
@end

NS_ASSUME_NONNULL_END
