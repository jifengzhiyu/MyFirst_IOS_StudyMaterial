//
//  HMSendClientViewController.h
//  Mac服务器01
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Client.h"

@interface HMSendClientViewController : NSViewController

//接收指定的客户端
@property(nonatomic,strong)Client *client;

@end
