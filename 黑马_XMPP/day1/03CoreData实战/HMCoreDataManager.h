//
//  HMCoreDataManager.h
//  03CoreData实战
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface HMCoreDataManager : NSObject

//创建一个管理对象上下文
@property (nonatomic , strong)NSManagedObjectContext *managerContext;

//简单的单例
+ (instancetype)sharedManager;


@end
