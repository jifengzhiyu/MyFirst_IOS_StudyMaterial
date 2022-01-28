//
//  ITCASTHelpCell.m
//  06网易彩票
//
//  Created by teacher on 15/7/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTHelpCell.h"
#import "ITCASTHelp.h"

@implementation ITCASTHelpCell

- (void)setHelp:(ITCASTHelp *)help
{
    _help = help;
    self.textLabel.text = help.title;
    self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
}

+ (instancetype)helpCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"help_cell";
    ITCASTHelpCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ITCASTHelpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

@end
