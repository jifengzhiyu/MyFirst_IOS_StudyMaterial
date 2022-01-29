# JSON 解析

## JSON 介绍

> JSON 本质上，就是一个"特殊格式"的字符串

* JSON 是网络上用来传输数据使用最广泛的数据格式，没有之一
* JSON 出身草根，是 `Javascript` 的子集，专门负责描述数据格式
* `Javascript` 是做网页开发使用的一种"脚本"语言
* `Javascript` & `Java` 没有任何关系！

参考网站：http://www.w3cschool.cc

### JSON 语法规则

* 数据以 `key/value` 值对表示
* 数据由逗号分隔
* 花括号保存对象
* 方括号保存数组

### JSON 值

* 数字（整数或浮点数）
* 字符串（在双引号中）
* 逻辑值（`true` 或 `false`）
* 数组（在方括号中）
* 对象（在花括号中）
* `null`

## 序列化 & 反序列化

* 序列化：在向服务器发送数据之前，将 `NSArray` / `NSDictionary` 转换成二进制的过程
* 反序列化：在从服务器接收到数据之后，将二进制数据转换成 `NSArray` / `NSDictionary` 的过程

### JSON 反序列化

* 天气预报接口

```objc
NSURL *url = [NSURL URLWithString:@"http://www.weather.com.cn/adat/sk/101010100.html"];
```

```objc
id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];

NSLog(@"%@ %@", result, [result class]);
```

| 选项 | 说明 |
| -- | -- |
| `NSJSONReadingMutableContainers = (1UL << 0)` | 容器可变 |
| `NSJSONReadingMutableLeaves = (1UL << 1)` | 叶子可变 |
| `NSJSONReadingAllowFragments = (1UL << 2)` | 顶级节点可以不是 NSArray 或者 NSDictionary |

* 在实际开发中，获得网络的数组或者字典之后，通常会做字典转模型！反序列化的结果是否可变并不重要

> 选项选择 `0`，表示任何附加操作都不做，效率最高！

#### NSJSONSerialization 类

* 专门负责在 `JSON` 和 `Foundation` 对象直接转换的类
* 可以转换成 `JSON` 的 `Foundation` 对象需要具备以下条件：
    * 顶级节点是 `NSArray` 或者 `NSDictionary`
    * 所有的对象是 `NSString`, `NSNumber`, `NSArray`, `NSDictionary` 或者 `NSNull`
    * 所有字典的 `key` 是 `NSString`
    * `NSNumber` 不是空或者无穷大



