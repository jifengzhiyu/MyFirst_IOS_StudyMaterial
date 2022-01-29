//
//  HMClientManagerCoreData.m
//  Mac服务器01
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMClientManagerCoreData.h"

@implementation HMClientManagerCoreData

static HMClientManagerCoreData *sharemangered;
+(instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharemangered = [HMClientManagerCoreData new];
    });
    return sharemangered;
}

-(NSManagedObjectContext *)managerContext
{
    if (_managerContext == nil) {
        //创建上下问
        _managerContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        
        //设置持久化存储协调器
        //创建模型文件
        NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:[[NSBundle mainBundle]URLForResource:@"Client" withExtension:@"momd"]];
        
        NSPersistentStoreCoordinator *per = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
        
        //数据库文件地址
        NSURL *url = [NSURL fileURLWithPath:@"/Users/apple/Desktop/person/client.db"];
        [per addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:nil];
        
        [_managerContext setPersistentStoreCoordinator:per];
    }
    return _managerContext;


}

@end
