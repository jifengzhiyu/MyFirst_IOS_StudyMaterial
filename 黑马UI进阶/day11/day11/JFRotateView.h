//
//  JFRotateView.h
//  day11
//
//  Created by 翟佳阳 on 2021/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JFRotateViewDelegate <NSObject>
- (void)showAlert;
@end


@interface JFRotateView : UIView
+ (instancetype)roteView;
- (void)startRotate;
@property (nonatomic, weak) id <JFRotateViewDelegate> delegate;
@property (nonatomic, strong) CADisplayLink *link;

@end

NS_ASSUME_NONNULL_END
