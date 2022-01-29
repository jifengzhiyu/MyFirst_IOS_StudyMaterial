//
//  HMCoreDataManager.m
//  03CoreData实战
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMCoreDataManager.h"


@implementation HMCoreDataManager


//实现单例
static HMCoreDataManager *sharemanager;

+(instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharemanager = [HMCoreDataManager new];
    });
    return sharemanager;
}


-(NSManagedObjectContext *)managerContext
{
    if (_managerContext == nil) {
        //创建对象
        _managerContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        //给上下文设置持久化存储协调器
        //模型文件的url
        NSURL *url = [[NSBundle mainBundle]URLForResource:@"Person" withExtension:@"momd"];
        //根据url 获取到模型文件
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
        //设置模型文件
        NSPersistentStoreCoordinator *per = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
        
        //数据路径一般放在沙盒 为了演示才放到电脑桌面
        NSURL *file = [NSURL fileURLWithPath:@"/Users/kaixin/Desktop/person/person.db"];
        
        //添加数据库文件路径
        [per addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:file options:nil error:nil];
        
        [_managerContext setPersistentStoreCoordinator:per];
    }
    return _managerContext;

}

@end
