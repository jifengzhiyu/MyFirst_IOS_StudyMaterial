//
//  HMDealTool.m
//  MeiTuanHD
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMDealTool.h"
#import <FMDB/FMDB.h>
#import "HMDealModel.h"

@implementation HMDealTool

/**
 创建数据库创建一次
 */

static FMDatabase *_db;
+ (void)load
{
    //1. 获取文件路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"deal.sqlite"];
    NSLog(@"path: %@", path);
    
    //2. 创建数据库
    _db = [FMDatabase databaseWithPath:path];
    
    //3. 判断是否打开
    if (![_db open]) {
        return;
    }
    
    //4. 创建表
    //CREATE TABLE IS NOT EXISTS: 创建表如果不存在
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_collect(id integer PRIMARY KEY, deal_model blob NOT NULL, deal_id text NOT NULL);"];
}


/** 添加一条数据*/
+ (void)insertCollectDeal:(HMDealModel *)dealModel
{
    //1. 将模型转换成 NSData
    //自定义归档, 模型遵守 NSCoding 协议 --> 实现2个方法
    // 使用框架自带的几个方法, 轻松实现归解档
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dealModel];
    
    //2. 添加数据
    [_db executeUpdateWithFormat:@"INSERT INTO t_collect(deal_id,deal_model) VALUES(%@,%@);", dealModel.deal_id, data];
}


/** 删除一条数据*/
+ (void)removeCollectDeal:(HMDealModel *)dealModel
{
    //删除数据
    [_db executeUpdateWithFormat:@"DELETE FROM t_collect WHERE deal_id=%@", dealModel.deal_id];
}


/** 判断数据库是否添加了模型数据*/
+ (BOOL)isCollectDeal:(HMDealModel *)dealModeal
{
    //count 0 : 1
    
    //COUNT(*): 查询的是个数 --> 单独的一列 ,为了取值方便, 可以取名字
    //AS: 起别名
    //1. 查询数据
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT COUNT(*) AS deal_count FROM t_collect WHERE deal_id=%@", dealModeal.deal_id];
    
    //2. 调用 next --> 只要想获取数据, 就必须调用此方法
    [set next];
    
    //3. 获取数据
    return [set intForColumn:@"deal_count"] == 1;
}


/** 根据传入的页码, 返回对应的数据*/
+ (NSArray *)collectDealModelWithPage:(NSInteger)page
{
    //1. 每次获取的个数
    NSInteger count = 20;
    
    //2. 开始查询的位置
    NSInteger loction = (page -1) * count;
    
    /**
     总数据  100, 每次查询20条  5页
     page   loction     data
      1        0       1~20
      2        20      21~40
      3        40      41~60
     */
    
    //ORDER BY: 排序
    //DESC: 逆序
    //LIMIT: 限制 (loction, count)
    //3. 查询数据
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT * FROM t_collect ORDER BY id DESC LIMIT %ld,%ld;", loction, count];
    
    //4. 判断是否有下一条数据
    
    NSMutableArray *tempArray = [NSMutableArray array];
    while ([set next]) {
        
        //5. 获取数据 --> 解档 --> 还原成模型
        //[set objectForColumnName:@"deal_model"]: 是归档后的模型
        HMDealModel *dealModel = [NSKeyedUnarchiver unarchiveObjectWithData:[set objectForColumnName:@"deal_model"]];
        
        //6. 将转换后的模型, 添加到临时数组中
        [tempArray addObject:dealModel];
    }
    
    return tempArray.copy;
}

/** 返回数据库的总个数*/
+ (NSInteger)totalCount
{
    //1. 查询数据 --> 查询所有数据的个数 --> 表中有多少条数据, 就返回多少
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT COUNT(*) AS deal_count FROM t_collect"];
    
    //2. 调用 next --> 只要想获取数据, 就必须调用此方法
    [set next];
    
    //3. 获取数据
    return [set intForColumn:@"deal_count"];
}

@end
