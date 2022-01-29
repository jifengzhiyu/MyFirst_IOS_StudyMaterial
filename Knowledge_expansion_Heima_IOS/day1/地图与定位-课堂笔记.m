
#pragma mark - 一. CoreLocation

01, 05, 08 建议大家练习一遍
#pragma mark 1. 实现一次定位 (掌握)
1. 创建CLLocationManager对象
2. 请求用户授权 --> 从iOS8开始, 必须在程序中请求用户授权, 除了写代码, 还要配置plist列表的键值
3. 设置代理 --> 获取用户位置
4. 调用开始定位方法
5. 代理方法中停止定位

#pragma mark 2. 实现持续定位 (了解)
1. 距离筛选器 --> 位置发生了一定的改变之后, 才去调用代理方法 降低方法的调用来达到省电的目的
2. 定位精准度 --> 降低通讯及计算的过程就可以省电

#pragma mark 3. CLLocation对象介绍 (理解)
1. 位置对象, 最核心的就是经纬度, coordinate : 2D位置坐标 --> 经纬度
2. 创建一个位置对象, 最少只需要两个值, 经纬度
3. 比较两个位置之间的距离: distanceFromLocation , 返回的是直线距离

#pragma mark 4. 请求用户授权 (理解)
1. 如果要授权, 从iOS8开始, 必须在程序中请求用户授权, 除了写代码, 还要配置plist列表的键值
2. 授权方式 -->requestWhenInUseAuthorization 当用户使用的使用授权
-->requestAlwaysAuthorization 永久授权方法
3. 一定要记得授权方法和plist列表匹配 (when / always)
NSLocationWhenInUseUsageDescription
NSLocationAlwaysUsageDescription

4. 如果2个方法都写, 会出现2此授权的情况 (第一次会走第一个方法, 第二次会走第二个方法 --> 一般使用1个方法即可
                         
5. 大部分的程序之使用 "使用期间" 这个授权即可. 如果说列表出出现了3个, 说明两个授权方法写了
6. plist的Value 可以不写, 写上是为了提示用户, 当前程序会在哪些地方使用定位. 建议写上, 提高用户打开的几率


#pragma mark 5. iOS9新特性-临时获取后台定位权限 (了解)
使用场景:当程序使用 "requestWhenInUseAuthorization" , 如果想要临时开启后台定位, 那么才需要使用新增的属性
1. allowsBackgroundLocationUpdates: 设置为YES即可, 还要配置plist列表 Required background modes : App registers for location updates

#pragma mark - 二. Geocoder

#pragma mark 1. 正地理编码 (理解)
正地理编码: 将地名 转换成 经纬度 的过程
1. 创建一个CLGeocoder对象
2. 实现地理编码方法
3. 遍历数组, 获取数据
注意: 地理编码 可能出现重名的问题, 所以将来如果对标对象大于1, 应该给用户一个列表选择

#pragma mark 2. 反地理编码(掌握)
反地理编码: 将经纬度 转换成 地名 的过程
1. 创建一个CLGeocoder对象
2. 创建一个CLLoction对象
3. 实现反地理编码方法
4. 遍历数组, 获取数据

#pragma mark - 三. MapView的基本使用

#pragma mark 1. 显示用户位置 (掌握)
1. CLLocationManager授权
2. userTrackingMode: 设置跟踪模式

#pragma mark 2. 设置地图显示类型 (掌握)
1. mapType : 设置地图类型 , 一般要使用默认, 要么使用混合, 单纯的卫星图没有意义.

#pragma mark 3. 根据用户位置显示对应的大头针信息(掌握)
1. 请参照反地理编码知识来设置userLocation 的相关属性即可

#pragma mark 4. 设置以用户所在位置为中心点(掌握)
1. 设置中心点坐标: centerCoordinate
2. 设置范围的属性: region 可以改变坐标, 也可以改变显示跨度
3. 如果想要变化时有动画: 调用set方法, 增加动画

#pragma mark 5. 获取地图显示区域改变时的中心点坐标及显示跨度 (了解)
实现放大和缩小地图的效果
1. Delta 跨度倍数处理
2. 重设region属性

#pragma mark 6. iOS9新特性-显示交通状况 / 显示比例 / 显示指南针 (了解)
1. 设置交通状况
2. 设置指南针(默认就是YES)
3. 设置比例尺

#pragma mark - 四. 大头针的使用

#pragma mark 1. 添加大头针 (掌握)
1. 添加大头针 --> 需要自定义大头针模型类
    1. 导入框架 MapKit
    2. 遵守协议 MKAnnotation
    3. 设置属性 直接去协议中拷贝-->删掉readonly
2. 创建大头针
3. 添加到地图上


#pragma mark 2. 自定义大头针1, 更改颜色, 设置掉落效果 (理解)
1. 如果发现是显示用户位置的大头针模型,  就返回nil
2. 自定义大头针View --> 跟Cell的创建几乎一样
---需要使用一个子类: MKPinAnnotationView : 子类是默认有View的--
3. 设置颜色
4. 设置动画掉落


#pragma mark 3. 自定义大头针2-更改大头针的图像 (掌握)
设置图像
1. 修改模型类, 增加属性
2. 在创建模型类的时候, 去设置相关属性icon
3. 在自定义大头针View的方法中设置图像  --> MVC

动画掉落
0. 处理显示用户位置的大头针View, 不要增加动画
1. 记录原本的位置
2. 将View的Y值改为0, 重设Frame
3. 将位置还原, 执行动画效果

#pragma mark 4. 自定义大头针的代码封装 (理解)
额外属性介绍
1. 设置可以点击呼唤出来之前设置的标题子标题
2. 设置左边 / 右边 / 详情 附属视图
                         
封装
1. 封装大头针View, --> 跟封装cell的过程几乎一样, 唯一一个地方不一样的是, 可以不用设置模型属型
                         
2.系统会自动调用该方法 annotation 的 set方法
   1. 必须调用父类方法
   2. 设置图像





