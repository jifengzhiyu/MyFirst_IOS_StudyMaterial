//
//  HMMateTool.m
//  MeiTuanHD
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMMateTool.h"
#import "HMCategoryModel.h"
#import "HMBusinessModel.h"

@implementation HMMateTool

/** 返回分类信息*/
static NSMutableArray *_categories;
+ (NSArray *)categories
{
    if (_categories == nil) {
        
        NSArray *categoryArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"categories.plist" ofType:nil]];
        
        _categories = [NSMutableArray array];
        for (NSDictionary *dict in categoryArray) {
            [_categories addObject:[HMCategoryModel yy_modelWithJSON:dict]];
        }
    }
    return _categories;
}


/** 根据模型来返回对应的地图信息*/
+ (NSString *)mapNameWithBusinessModel:(HMBusinessModel *)businessModel
{
    //1. 加载 plist
    NSArray *categoryArray = [self categories];
    
    //2. 暂时自取一个分类信息来遍历 --> 模型的分类可能有多个值
    NSString *categoryStr = [businessModel.categories firstObject];
    
    //3. 遍历 plist 列表
    for (HMCategoryModel *categoryModel in categoryArray) {
        //3.1 name是否相同
        if ([categoryModel.name isEqualToString:categoryStr]) {
            return categoryModel.map_icon;
        } else if ([categoryModel.subcategories containsObject:categoryStr]) {
            //3.2 判断子分类是否和服务器返回的分类名相同
            return categoryModel.map_icon;
        }
    }

    // 如果什么都没找到, 就返回 nil
    return nil;
}


@end
