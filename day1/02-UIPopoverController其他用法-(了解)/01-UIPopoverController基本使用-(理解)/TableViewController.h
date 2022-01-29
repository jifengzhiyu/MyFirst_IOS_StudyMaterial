//
//  TableViewController.h
//  01-UIPopoverController基本使用-(理解)
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController

//1. 生成block属性
@property (nonatomic, copy) void(^cellDidClick)(UIColor *color);

@end
