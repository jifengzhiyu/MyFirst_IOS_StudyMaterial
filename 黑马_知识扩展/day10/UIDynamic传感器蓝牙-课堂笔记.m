
#pragma mark - 二. 传感器

#pragma mark 1. 距离传感器 (了解)
1. 开启距离传感器 --> UIDivece --> proximityMonitoringEnabled
2. 注册通知
3. 通知的方法获取通知的值 --> UIDivece --> proximityState

#pragma mark 2. 加速计传感器 (了解)


#pragma mark 3. 运动管理器 (理解)
运动管理器包含了加速计 陀螺仪和磁力计

正值负值: 轴的方向, 哪个指向地面, 就会打印出打个方向的值
只要在某个轴上, 进行快速移动, 那么值就会发生变化

一. 加速计的Push方式 --> 只要系统获取到了值, 就会返回给你
1. 创建CMMotionManager对象
2. 判断加速计是否可用
3. 设置采样间隔 单位是秒
4. 开始采样


二. 加速计的Pull方式 --> 在需要的时候来获取值
1. 创建CMMotionManager对象
2. 判断加速计是否可用
3. 开始采样
4. 在需要获取的方法中(比如touch), 可以通过CMMotionManager属性来获取值

三. 陀螺仪和磁力计的方式类似于加速计, 自行替换关键词即可


#pragma mark 4. 摇一摇 (掌握)
使用系统封装号的motionBegan方法

#pragma mark 5. 计步器 (理解)
CMPedameter
1. 判断是否可用
2. 创建计步器
3. 开始获取

#pragma mark - 三. 蓝牙

#pragma mark 1. GameKit (理解)
前提: 使用GameKit/GameKit.h
一. 连接设备
1. 创建GKPeerPickerController连接控制器
2. 设置代理 --> 获取数据
3. 显示控制器 --> show 此控制器和AlertView很像, 不是全屏的, 不用push modal

二. GKPeerPickerController代理方法中
1. 保留session
2. 设置句柄 (设置代理) --> 将来一旦受到数据, 将由句柄的方法来处理数据
3. 消失控制器

4. 一旦设置了句柄, 还需要实现此方法receiveData(如果不记得, 可以跳进官方文档, 进行查看)

三. 句柄方法
1. 将Data转换成image对象
2. 然后设置到界面上

四. 发送方法
1. 将image转换成Data
2. 使用会话类发送数据


#pragma mark 2. CoreBuletooth (理解)
1. 建立中央管理者
2. 扫描周边设备
3. 当发现外围设备时, 会调用的方法, 在此方法中记录扫描到的设备
4. (用户点击后的方法)连接扫描到的设备 --> 此方法是咱们自己写的,连接外围设备
5. 设置外围设备的代理 --> 一旦连接外设, 那么将有外设来管理服务和特征的处理
6. 连接到外设时会调用的代理方法中扫描服务
7. 当发现到服务的时候会调用的代理方法中, 获取指定的服务, 然后根据此服务来查找特征
8. 获取指定的特征, 然后根据此特征, 才能根据自己的需求进行数据交互处理
9. 断开连接


