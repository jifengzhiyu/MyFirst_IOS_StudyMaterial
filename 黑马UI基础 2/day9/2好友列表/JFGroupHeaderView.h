//
//  JFGroupHeaderView.h
//  2好友列表
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JFGroup;
@class JFGroupHeaderView;

//设置协议
@protocol JFGroupHeaderViewDelegate <NSObject>

- (void) groupHeaderViewDidClickTitleButton:(JFGroupHeaderView *)groupHeaderView;

@end

@interface JFGroupHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) JFGroup *group;

//增加一个代理属性
@property (nonatomic, weak) id<JFGroupHeaderViewDelegate> delegate;
+ (instancetype)groupHeaderViewWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
