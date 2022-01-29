//
//  ViewController.h
//  Mac服务器01
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GCDAsyncSocket.h"

@interface ViewController : NSViewController

//设置一个服务器
@property(nonatomic,strong)GCDAsyncSocket *server;


@end

