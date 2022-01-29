//
//  ViewController.m
//  Mac服务器01
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "HMClientManagerCoreData.h"
#import "Client.h"


@interface ViewController ()<GCDAsyncSocketDelegate>
@property (weak) IBOutlet NSTextField *portNumber;

//给一个数组 数据里的元素是什么类型  GCDAsyncSocket
@property(nonatomic,strong)NSMutableArray *clientArrsScoket;

//创建时钟
@property(nonatomic,strong)NSTimer *time;

@end

@implementation ViewController

-(NSMutableArray *)clientArrsScoket
{
    if (_clientArrsScoket == nil) {
        _clientArrsScoket = [NSMutableArray array];
    }
    return _clientArrsScoket;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

//创建服务器连接管道
-(GCDAsyncSocket *)server
{
    if (_server == nil) {
        _server = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _server;
}


//监听端口
- (IBAction)listenToSocket:(id)sender {
    
    // 使用socket  监听并且绑定
    [self.server acceptOnPort:self.portNumber.intValue error:nil];
    
    //连接之后读取数据
    [self readData];
    
    //接受指定的客户端,在数组中查找到指定的这个客户端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendMessageNotification:) name:@"sendMessage" object:nil];
}

- (void)sendMessageNotification:(NSNotification *)info
{

    //接收到参数
    NSDictionary *dict = info.userInfo;
    
    Client *client = dict[@"client"];
    NSString *message = dict[@"message"];
    
    
    //在clientArrsScoket数组中查找 ip 地址和 端口号一致的元素 ,这个元素是一个GCDAsyncSocket
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"connectedHost = %@  and connectedPort = %@",client.ipaddress,client.portNumber];
    //按照要求查找到指定的数据并且返回给一个数组保存
    NSArray *temp =  [self.clientArrsScoket filteredArrayUsingPredicate:pre];
      NSLog(@"%lu",temp.count);
    
    
    //给指定的客户端发送数据
    for (GCDAsyncSocket *socket in temp) {
      
        [socket writeData:[message dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    }
    
}

//通过代理告诉我们
/// socket:didAcceptNewSocket:
///
/// @param sock      服务器的socket
/// @param newSocket 新来的客户端socket
-(void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    //持有newSocket 不让释放
    [self.clientArrsScoket addObject:newSocket];
    NSLog(@"newSocket = %@",newSocket);
    
    //存储
  Client *client = [NSEntityDescription insertNewObjectForEntityForName:@"Client" inManagedObjectContext:[HMClientManagerCoreData shareManager].managerContext];
    
    //赋值存储
    client.ipaddress = newSocket.connectedHost;
    client.portNumber = @(newSocket.connectedPort);
    client.connectTime = [NSDate new];
    client.disconnectTime = nil;
    
    //提交保存
    [[HMClientManagerCoreData shareManager].managerContext save:nil];
    
    //通知更多客户端界面刷新数据
    [[NSNotificationCenter defaultCenter] postNotificationName:@"moreClientReloaddata" object:nil];
    
    //通过指定newsocket 读取数据
//    [newSocket readDataWithTimeout:-1 tag:0];
    
}

- (void)readData
{
    self.time = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(readingData) userInfo:nil repeats:YES];
    
    //添加到当前的运行循环中去
    [[NSRunLoop currentRunLoop] addTimer:self.time forMode:NSRunLoopCommonModes];
}

//始终停止
- (void)stopTime
{
    [self.time invalidate];
    self.time = nil;
}

- (void)readingData
{
    //通过数据遍历调用读取数据的方法
    for (GCDAsyncSocket *newSocket in self.clientArrsScoket) {
        //通过指定newsocket 读取数据
        [newSocket readDataWithTimeout:-1 tag:0];
    }
}

//通过代理接收数据
-(void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"客户端发来的贺电 = %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
}

@end
