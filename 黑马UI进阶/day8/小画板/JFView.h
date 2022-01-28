//
//  JFView.h
//  小画板
//
//  Created by 翟佳阳 on 2021/10/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFView : UIView
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *lineColor;

- (void)eraser;

- (void)back;

- (void)clear;
@end

NS_ASSUME_NONNULL_END
