//
//  Dog.h
//  protocol协议
//
//  Created by 翟佳阳 on 2021/8/18.
//

#import <Foundation/Foundation.h>
#import "MyProtocol.h"
#import "YourProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject <MyProtocol,YourProtocol>


@end

NS_ASSUME_NONNULL_END
