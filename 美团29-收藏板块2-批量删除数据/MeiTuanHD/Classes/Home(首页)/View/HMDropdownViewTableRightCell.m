//
//  HMDropdownViewTableRightCell.m
//  MeiTuanHD
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMDropdownViewTableRightCell.h"

@implementation HMDropdownViewTableRightCell

/** 创建右边表格的方法*/
+ (instancetype)dropdownViewTableRightCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier= @"rightCell";
    
    HMDropdownViewTableRightCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell=[[HMDropdownViewTableRightCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
        // 设置背景图片
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
        
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
    }
    return cell;
}

@end
