//
//  JFWeiboCellTableViewCell.h
//  微博
//
//  Created by 翟佳阳 on 2021/9/15.
//

#import <UIKit/UIKit.h>
@class JFWeiboFrame;
NS_ASSUME_NONNULL_BEGIN

@interface JFWeiboCell : UITableViewCell
@property(nonatomic,strong)JFWeiboFrame *weiboFrame;

+ (instancetype)weiboCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
