//
//  HMSendClientViewController.m
//  Mac服务器01
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMSendClientViewController.h"

@interface HMSendClientViewController ()
@property (weak) IBOutlet NSTextField *messageText;

@end

@implementation HMSendClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    //设置标题
    self.title = [NSString stringWithFormat:@"IP%@:port%@",self.client.ipaddress,self.client.portNumber];
}


- (IBAction)toClientMessage:(id)sender {
    //发送的参数,一个是客户端对象  Client  还有一个 message
    //通过字典来存
    NSDictionary *dict = @{
                           @"client":self.client,
                           @"message":self.messageText.stringValue
                           };
    
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sendMessage" object:nil userInfo:dict];
}

@end
