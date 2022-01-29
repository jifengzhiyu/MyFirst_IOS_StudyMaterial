//
//  HMDropDownView.m
//  MeiTuanHD
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMDropdownView.h"
#import "HMCategoryModel.h"
#import "HMDropdownViewTableLeftCell.h"
#import "HMDropdownViewTableRightCell.h"
#import "HMDistrictModel.h"

@interface HMDropdownView ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;


/** 选中的左边分类模型 */
@property (nonatomic, strong) HMCategoryModel *selectLeftCategoryModel;

/** 选中的左边区域模型 */
@property (nonatomic, strong) HMDistrictModel *selectLeftDistrictModel;

///** 选中的左边分类索引 */
//@property (nonatomic, assign) NSInteger selectLeftCategoryIndex;

@end

@implementation HMDropdownView

/** 提供类方法, 加载 xib*/
+ (instancetype)dropDownView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HMDropdownView" owner:nil options:nil] firstObject];
}

#pragma mark 使用 xib 的时候
- (void)awakeFromNib
{
    /**
     1. 当一个较大的视图, 放到较小的视图里, 视图肯定会发生压缩行为
     2. autoLayout 会勾选autoresizing相关的属性. 导致压缩时, 视图也会跟着压缩. 有可能就压缩看不见了
     */
    self.autoresizingMask = UIViewAutoresizingNone;
}

#pragma mark TableView 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    /**
     1. 对之前的代码, 增加一层 if 判断, 通知需要对 else 里的代码, 
     2. 将 category 换成 district
     */
    
//    //1.1 判断分类有值
//    if (self.categoryArray) {
//        //1.2 判断分类左边数据
//        if (tableView == self.leftTableView) {
//            
//        } else {
//            //1.3 判断分类右边数据
//        }
//    } else {
//        //2.1 区域有值
//        //1.2 判断区域左边数据
//        if (tableView == self.leftTableView) {
//            
//        } else {
//            //1.3 判断区域右边数据
//        }
//    }
    
    
    // 如果分类数据有值
    if (self.categoryArray) {
        //根据数据源的 tableView 属性, 来判断是哪个表格
        if (tableView == self.leftTableView) {
            return self.categoryArray.count;
        } else {
            //需要知道左边选中了谁 -->用一个属性来记录选中的左边模型
            return self.selectLeftCategoryModel.subcategories.count;
        }
    } else {
        // 区域数据有值
        
        //根据数据源的 tableView 属性, 来判断是哪个表格
        if (tableView == self.leftTableView) {
            return self.districtArray.count;
        } else {
            //需要知道左边选中了谁 -->用一个属性来记录选中的左边模型
            return self.selectLeftDistrictModel.subdistricts.count;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 分类数据有值
    if (self.categoryArray) {
        // 判断是左边表格
        if (tableView == self.leftTableView) {
            
            // 创建左边 cell
            HMDropdownViewTableLeftCell *cell = [HMDropdownViewTableLeftCell dropdownViewTableLeftCellWithTableView:tableView];
            
            
            //1. 获取模型数据
            HMCategoryModel *categoryModel = self.categoryArray[indexPath.row];
            
            //2. 赋值
            cell.textLabel.text = categoryModel.name;
            
            //3. 显示箭头
            if (categoryModel.subcategories.count) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            //4. 设置图标
            cell.imageView.image = [UIImage imageNamed:categoryModel.icon];
            
            //5. 设置高亮图标
            cell.imageView.highlightedImage = [UIImage imageNamed:categoryModel.highlighted_icon];
            
            return cell;
        } else {
            HMDropdownViewTableRightCell *cell = [HMDropdownViewTableRightCell dropdownViewTableRightCellWithTableView:tableView];
            
            //1. 赋值
            cell.textLabel.text = self.selectLeftCategoryModel.subcategories[indexPath.row];
            
            return cell;
        }
    } else {
        // 区域数据有值
        
        // 判断是左边表格
        if (tableView == self.leftTableView) {
            
            // 创建左边 cell
            HMDropdownViewTableLeftCell *cell = [HMDropdownViewTableLeftCell dropdownViewTableLeftCellWithTableView:tableView];
            
            
            //1. 获取模型数据
            HMDistrictModel *districtModel = self.districtArray[indexPath.row];
            
            //2. 赋值
            cell.textLabel.text = districtModel.name;
            
            //3. 显示箭头
            if (districtModel.subdistricts.count) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            // 显示城市不需要图标
            
            return cell;
        } else {
            HMDropdownViewTableRightCell *cell = [HMDropdownViewTableRightCell dropdownViewTableRightCellWithTableView:tableView];
            
            //1. 赋值
            cell.textLabel.text = self.selectLeftDistrictModel.subdistricts[indexPath.row];
            
            return cell;
        }
    }
    
}

#pragma mark 选中的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 分类数据有值
    if (self.categoryArray) {
        //点击左边时, 才需要记录
        if (tableView == self.leftTableView) {
            //1. 记录左边选中的模型
            self.selectLeftCategoryModel = self.categoryArray[indexPath.row];
            
            //2. 如果没有子分类数据, 直接发送通知
            if (self.selectLeftCategoryModel.subcategories.count == 0) {
                // 发送通知
                [HMNotificationCenter postNotificationName:HMCategoryDidChangeNotifacation object:nil userInfo:@{HMSelectCategoryModel : self.selectLeftCategoryModel}];
            }
            
        } else  {
            // 点击右边
            
            // 发送通知
            [HMNotificationCenter postNotificationName:HMCategoryDidChangeNotifacation object:nil userInfo:@{HMSelectCategoryModel : self.selectLeftCategoryModel, HMSelectCategorySubtitle : self.selectLeftCategoryModel.subcategories[indexPath.row]}];
        }

    } else {
        //2. 区域数据有值
        
        //点击左边时, 才需要记录
        if (tableView == self.leftTableView) {
            //1. 记录左边选中的模型
            self.selectLeftDistrictModel = self.districtArray[indexPath.row];
            
            //2. 如果没有子区域数据, 直接发送通知
            if (self.selectLeftDistrictModel.subdistricts.count == 0) {
                // 发送通知
                [HMNotificationCenter postNotificationName:HMDistrictDidChangeNotifacation object:nil userInfo:@{HMSelectDistrictModel : self.selectLeftDistrictModel}];
            }
            
        } else {
            // 选中的是右边
            
            // 发送通知
            [HMNotificationCenter postNotificationName:HMDistrictDidChangeNotifacation object:nil userInfo:@{HMSelectDistrictModel : self.selectLeftDistrictModel, HMSelectDistrictSubtitle : self.selectLeftDistrictModel.subdistricts[indexPath.row]}];
            
        }
    }
    
    //2. 刷新右边表格
    [self.rightTableView reloadData];
}

@end
