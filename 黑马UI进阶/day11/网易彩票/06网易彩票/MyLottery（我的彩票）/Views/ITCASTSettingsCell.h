//
//  ITCASTSettingsCell.h
//  06网易彩票
//
//  Created by teacher on 15/7/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITCASTSettingsCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *item;

+ (instancetype)settingsCellWithTableView:(UITableView *)tableView dict:(NSDictionary *)dict;

- (void)setTime:(NSString *)strTime;
@end
