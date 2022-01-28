//
//  JFMessageCell.h
//  day8
//
//  Created by 翟佳阳 on 2021/9/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JFMessageFrame;
@interface JFMessageCell : UITableViewCell
@property(nonatomic, strong)JFMessageFrame *messageFrame;

+(instancetype)messageCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
