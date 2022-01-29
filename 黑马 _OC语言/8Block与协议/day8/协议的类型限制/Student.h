//
//  Student.h
//  协议的类型限制
//
//  Created by 翟佳阳 on 2021/8/19.
//

#import <Foundation/Foundation.h>
#import "StudtyProtocol.h"
#import "AbaProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject <StudtyProtocol,AbaProtocol>

@end

NS_ASSUME_NONNULL_END
