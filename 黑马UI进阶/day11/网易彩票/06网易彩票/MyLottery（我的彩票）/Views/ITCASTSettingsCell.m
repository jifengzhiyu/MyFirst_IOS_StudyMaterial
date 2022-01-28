//
//  ITCASTSettingsCell.m
//  06网易彩票
//
//  Created by teacher on 15/7/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTSettingsCell.h"

@implementation ITCASTSettingsCell

+ (UITableViewCellStyle)cellStyleWithDict:(NSDictionary *)dict
{
    UITableViewCellStyle cellStyle = UITableViewCellStyleDefault;
    
    if ([dict[@"cellStyle"] isEqualToString:@"UITableViewCellStyleSubtitle"]) {
        cellStyle = UITableViewCellStyleSubtitle;
    } else if ([dict[@"cellStyle"] isEqualToString:@"UITableViewCellStyleValue1"]) {
        cellStyle = UITableViewCellStyleValue1;
    } else  if ([dict[@"cellStyle"] isEqualToString:@"UITableViewCellStyleValue2"]) {
        cellStyle = UITableViewCellStyleValue2;
    }
    return cellStyle;
}

+ (instancetype)settingsCellWithTableView:(UITableView *)tableView dict:(NSDictionary *)dict
{
    //static NSString *ID = @"setting_cell";
    
    NSString *ID = dict[@"cellStyle"];
    ITCASTSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ITCASTSettingsCell alloc] initWithStyle: [self cellStyleWithDict:dict] reuseIdentifier:ID];
    }
    return cell;
}


- (void)setTime:(NSString *)strTime
{
    // 1. 把用户选择的日期设置给label
    self.detailTextLabel.text = strTime;
    
    // 2. 把用户选择的日期保存到"偏好设置"中
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    [usrDefault setObject:strTime forKey:self.item[@"detailsKeyName"]];
    [usrDefault synchronize];
}
- (void)setItem:(NSDictionary *)item
{
    _item = item;
    
    // 设置标题
    self.textLabel.text = item[@"title"];
    // 设置头像
    if (item[@"icon"]) {
        self.imageView.image = [UIImage imageNamed:item[@"icon"]];
    }
    // 设置详细信息
    if (item[@"details"] && [item[@"details"] length] > 0) {
        self.detailTextLabel.text = item[@"details"];
        
        // 判断当前的cell的details信息是否需要高亮显示
        if (item[@"isHighlighted"]) {
            self.detailTextLabel.textColor = [UIColor redColor];
        }
        
    }
    
    // 判断当前cell中的details信息, 是否在偏好设置中已经设置好了
    if (item[@"detailsKeyName"]) {
        // 从偏好设置中读取存储的内容
        NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
        NSString *text = [usrDefault objectForKey:item[@"detailsKeyName"]];
        
        // 如果存储的内容不为空
        if (text) {
            self.detailTextLabel.text = text;
        }
    }
    
    
    // 3.2 设置cell右侧的accessoryView
    if (item[@"accessory"] && [item[@"accessory"] length] > 0) {
        // 这句代码的意思就是根据配置文件中的字符串（UIImageView）, 创建一个对应的类型
        Class accessoryClass = NSClassFromString(item[@"accessory"]);
        
        // 创建这个类型的对象
        // 下面的这句代码有可能创建的是开关，也有可能创建的是UIImageView
        id obj = [[accessoryClass alloc] init];
        
        if ([obj isKindOfClass:[UIImageView class]]) {
            // 表示是图片框
            UIImageView *imgView = (UIImageView *)obj;
            imgView.image = [UIImage imageNamed:item[@"accessoryImage"]];
            
            // 调整图片框的大小和当前所显示的图片一样大
            [imgView sizeToFit];
        }
        
        // 设置Cell的accessoryView为动态创建的这个类型
        self.accessoryView = obj;
        
        
        // 判断如果是开关, 那么就为开关注册一个value changed事件
        if ([obj isKindOfClass:[UISwitch class]]) {
            // 为开关注册一个value changed事件
            UISwitch *switcher = (UISwitch *)obj;
            [switcher addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventTouchUpInside];
            
            // 从偏好设置中读取开挂的值, 并设置
             NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
            // 读取
            switcher.on = [usrDefault boolForKey:self.item[@"keyName"]];
        }
        
    }

}

- (void)switchValueChanged:(UISwitch *)sender
{
    // 1. 获取开关的状态
    // 2. 把开关状态保存到"偏好设置"中
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    [usrDefault setBool:sender.isOn forKey:self.item[@"keyName"]];
    [usrDefault synchronize];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
