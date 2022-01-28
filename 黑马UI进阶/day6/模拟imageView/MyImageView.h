//
//  MyImageView.h
//  模拟imageView
//
//  Created by 翟佳阳 on 2021/10/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyImageView : UIView
@property (nonatomic, strong) UIImage *image;
- (instancetype)initWithImage: (UIImage *)image;

@end

NS_ASSUME_NONNULL_END
