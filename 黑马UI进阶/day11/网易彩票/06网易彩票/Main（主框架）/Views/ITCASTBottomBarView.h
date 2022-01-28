//
//  ITCASTBottomBarView.h
//  06网易彩票
//
//  Created by teacher on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ITCASTBottomBarView;
@protocol ITCASTBottomBarViewDelegate <NSObject>

- (void)bottomBarView:(ITCASTBottomBarView *)bottomBarView didClickBottomBarButtonWithIndex:(int)idx;

@end

@interface ITCASTBottomBarView : UIView

- (void)addBottomBarButtonWithNormalBg:(NSString *)normal selectedBg:(NSString *)selected;

@property (nonatomic, weak) id<ITCASTBottomBarViewDelegate> delegate;
@end
