//
//  View.h
//  常用结构体
//
//  Created by 翟佳阳 on 2021/8/24.
//

#import <Foundation/Foundation.h>
#import "Button.h"
NS_ASSUME_NONNULL_BEGIN

@interface View : NSObject
@property(nonatomic,assign)CGPoint point;
@property(nonatomic,assign)CGSize size;
@property(nonatomic,strong)NSMutableArray * subViews;
@end

NS_ASSUME_NONNULL_END
