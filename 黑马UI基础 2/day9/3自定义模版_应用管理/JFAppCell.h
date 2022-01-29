//
//  JFAppCell.h
//  3自定义模版_应用管理
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JFApp;
@class JFAppCell;
@protocol JFAppCellDelegate <NSObject>

- (void)appCellDidClickDownloadButton:(JFAppCell *)appCell;

@end

@interface JFAppCell : UITableViewCell
@property (nonatomic, strong)JFApp *app;

//增加一个代理属性，为了弹出文本框
@property (nonatomic, weak)id<JFAppCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
