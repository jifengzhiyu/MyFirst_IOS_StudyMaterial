//
//  Person.h
//  依赖关系
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>
#import "Phone.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject


- (void)callWithPhone:(Phone*)phone;
@end

NS_ASSUME_NONNULL_END
