//
//  HMClientManagerCoreData.h
//  Mac服务器01
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface HMClientManagerCoreData : NSObject


//管理对象上下问
@property(nonatomic,strong)NSManagedObjectContext *managerContext;

//单利
+(instancetype)shareManager;

@end
