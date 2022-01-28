//
//  Perosn.h
//  协议的使用
//
//  Created by 翟佳阳 on 2021/8/18.
//

#import <Foundation/Foundation.h>
#import "SportProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@protocol EatProtocol <NSObject>

- (void)chifan;
- (void)hetang;

@end

@interface Person : NSObject <EatProtocol>

- (void)playLOL;
- (void)paShan;

@end

NS_ASSUME_NONNULL_END
