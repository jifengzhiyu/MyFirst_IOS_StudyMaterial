//
//  HMDropdownViewTableLeftCell.m
//  MeiTuanHD
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMDropdownViewTableLeftCell.h"

@implementation HMDropdownViewTableLeftCell

/** 创建左边表格的方法*/
+ (instancetype)dropdownViewTableLeftCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier= @"leftCell";
    
    HMDropdownViewTableLeftCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell=[[HMDropdownViewTableLeftCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
        // 设置背景图片
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
        
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
    }
    
    return cell;
}

@end
