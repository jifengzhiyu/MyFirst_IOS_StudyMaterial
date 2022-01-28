//
//  FlagView.h
//  国旗选择
//
//  Created by 翟佳阳 on 2021/9/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Flag;
@interface FlagView : UIView
@property (nonatomic, strong)Flag *flag;

+(instancetype)flagView;
+(CGFloat)rowHeight;
@end

NS_ASSUME_NONNULL_END
