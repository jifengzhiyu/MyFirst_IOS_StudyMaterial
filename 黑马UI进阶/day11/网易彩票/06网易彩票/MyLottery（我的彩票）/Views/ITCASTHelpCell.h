//
//  ITCASTHelpCell.h
//  06网易彩票
//
//  Created by teacher on 15/7/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ITCASTHelp;
@interface ITCASTHelpCell : UITableViewCell

+ (instancetype)helpCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) ITCASTHelp *help;
@end
