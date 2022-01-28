//
//  JFGoodsCell.h
//  day7
//
//  Created by 翟佳阳 on 2021/9/14.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class JFGoods;

@interface JFGoodsCell : UITableViewCell

@property(nonatomic,strong)JFGoods *goods;

//封装一个自定义cell的方法
+ (instancetype)goodsCellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
