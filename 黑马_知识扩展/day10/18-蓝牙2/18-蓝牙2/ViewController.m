//
//  ViewController.m
//  18-蓝牙2
//
//  Created by AndyDev on 15/7/16.
//  Copyright (c) 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate, CBPeripheralDelegate>
@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) NSMutableArray *peripheral;
@end

@implementation ViewController

#pragma mark - 懒加载
- (CBCentralManager *)centralManager
{
    //1. 创建中央管理器
    if (_centralManager == nil) {
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _centralManager;
}

- (NSMutableArray *)peripheral
{
    if (_peripheral == nil) {
        _peripheral = [NSMutableArray array];
    }
    return _peripheral;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    //1. 创建中央管理器
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
     */
    
    //2. 扫面外围设备
    // Services 扫描有某种服务的外围设备(比如具有开关空调服务的设备)
    // 传入nil表示扫描所有的服务
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    
}

//3. 发现外围设备时调用
//信号信息(特征)
//信号强度
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    //保留外围设备
    if (![self.peripheral containsObject:peripheral]) {
        [self.peripheral addObject:peripheral];
    }
    NSLog(@"发现了蓝牙设备");
    
    //这里应该给用户一个列表让其选择, 然后调用我们的连接方法
    //[self connectPeripheral:选中的外围设备];
}

//4. 连接外围设备(自己写)
- (void)connectPeripheral:(CBPeripheral *)peripheral
{
    [self.centralManager connectPeripheral:peripheral options:nil];
}

//5. 当连接上某一个外围设备调用的代理
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    //指定要扫描的服务
    [peripheral discoverServices:nil];
    
    //设置外围设备的代理
    peripheral.delegate = self;
}

//6. 当外围设备扫描到服务时候调用
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error) return;
    
    //当扫描到服务时, 会添加到peripheral.services中
    for (CBService *service in peripheral.services) {
        //拿到服务
        if ([service.UUID.UUIDString isEqualToString:@"123"]) {
            //拿到特征
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

//7. 当外围设备扫描到特征时候调用
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error) return;
    
    //当扫描到特征时, 会添加到service.characteristics中
    for (CBCharacteristic *characteristic in service.characteristics) {
        //拿到特性
        if ([characteristic.UUID.UUIDString isEqualToString:@"123"]) {
            //根据需求处理
            [peripheral readValueForCharacteristic:characteristic];
//            peripheral writeValue:<#(nonnull NSData *)#> forDescriptor:<#(nonnull CBDescriptor *)#>
        }
    }
}

//断开链接
- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear: animated];
    [self.centralManager stopScan];
}
/**
 *  中心管理者状态发生改变时会调用(查看自己的设备是否支持蓝牙4.0,或者是否打开了蓝牙4.0)
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"蓝牙状态发生了改变");
}

@end
