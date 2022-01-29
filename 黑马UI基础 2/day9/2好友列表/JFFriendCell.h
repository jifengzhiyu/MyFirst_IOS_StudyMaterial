//
//  JFFriendCell.h
//  2好友列表
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JFFriend;
@interface JFFriendCell : UITableViewCell
@property (nonatomic, strong)JFFriend *friendModel;

+ (instancetype)friendCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
