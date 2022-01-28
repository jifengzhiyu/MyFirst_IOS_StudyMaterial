//
//  ITCASTLiveScorePushController.m
//  06网易彩票
//
//  Created by teacher on 15/7/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTLiveScorePushController.h"
#import "UIView+ITCASTExt.h"
#import "ITCASTSettingsCell.h"

@interface ITCASTLiveScorePushController ()

// 懒加载工具栏
@property (nonatomic, strong) UIToolbar *toolBar;

// 懒加载日期选择控件
@property (nonatomic, strong) UIDatePicker *datePicker;

// 懒加载文本框
@property (nonatomic, strong) UITextField *txtField;
@end

@implementation ITCASTLiveScorePushController

- (UITextField *)txtField
{
    if (_txtField == nil) {
        _txtField = [[UITextField alloc] init];
        _txtField.inputView = self.datePicker;
        _txtField.inputAccessoryView = self.toolBar;
    }
    return _txtField;
}


- (UIDatePicker *)datePicker
{
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeTime;
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
    }
    return _datePicker;
}


- (UIToolbar *)toolBar
{
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc] init];
        _toolBar.h = 44;
        //_toolBar.backgroundColor = [UIColor purpleColor];
        _toolBar.barTintColor = [UIColor purpleColor];
        // 添加3个UIBarButtonItem
        // 取消
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(keyBoardCancel)];
        // 弹簧
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        // 完成
        UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(keyBoardDone)];
        
        _toolBar.items = @[item1, item2, item3];
    }
    return _toolBar;
}
// 键盘的取消按钮
- (void)keyBoardCancel
{
    [self.view endEditing:YES];
}

// 键盘的完成操作
- (void)keyBoardDone
{
    //NSLog(@"done.....");
    // 1. 获取用户选择的日期
    NSDate *userDate = self.datePicker.date;
    
    
    // 2. 把NSDate转换为一个字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *strDate = [formatter stringFromDate:userDate];
    
    // 3. 把用户选择的日期设置给当前选中的cell中的label
    // 3.1 获取用户当前选中的Cell
    NSIndexPath *idx = [self.tableView indexPathForSelectedRow];
    ITCASTSettingsCell *cell = (ITCASTSettingsCell *)[self.tableView cellForRowAtIndexPath:idx];
    
    // 3.2 把日期设置给Cell中的Label
    //cell.detailTextLabel.text = strDate;
    [cell setTime:strDate];
    
    
    // 4. 关闭键盘
    [self.view endEditing:YES];
    
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 懒加载文本框
    //[self txtField];
    
    // 2. 把文本框添加到cell中
    // 2.1 获取当前用户所选择的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.contentView addSubview:self.txtField];
    
    
    // 3. 让文本框变成第一响应者
    [self.txtField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}




@end
