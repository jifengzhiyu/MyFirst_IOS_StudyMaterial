//
//  Client+CoreDataProperties.h
//  Mac服务器01
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 itheima. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Client.h"

NS_ASSUME_NONNULL_BEGIN

@interface Client (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *portNumber;
@property (nullable, nonatomic, retain) NSString *ipaddress;
@property (nullable, nonatomic, retain) NSDate *connectTime;
@property (nullable, nonatomic, retain) NSDate *disconnectTime;

@end

NS_ASSUME_NONNULL_END
