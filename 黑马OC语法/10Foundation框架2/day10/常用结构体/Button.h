//
//  Button.h
//  常用结构体
//
//  Created by 翟佳阳 on 2021/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Button : NSObject
@property(nonatomic,assign)CGPoint point;
@property(nonatomic,assign)CGSize size;
@property(nonatomic,strong)NSString * text;
- (void)show;
- (void)hide;
@end

NS_ASSUME_NONNULL_END
