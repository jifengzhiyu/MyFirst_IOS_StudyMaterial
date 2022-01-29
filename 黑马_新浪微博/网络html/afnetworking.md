# AFNetworking

## 简介

- 目前国内开发网络应用使用最多的第三方框架
- 是专为 `Mac OS` & `iOS` 设计的一套网络框架
- 对 `NSURLConnection` 和 `NSURLSession` 做了封装
- 提供有丰富的 API
- 提供了完善的错误解决方案
- 使用简单

## 官网地址

https://github.com/AFNetworking/AFNetworking

## 学习第三方框架的步骤

1. 获取框架
    ```bash
    $ git clone https://github.com/AFNetworking/AFNetworking.git
    # 更新框架
    $ git pull
    ```
2. 查看官方文档
3. 运行演示程序
4. 建立学习分支
    * `分支`是学习第三方框架和入手公司项目的重要手段！
5. 编写测试程序
6. 少百度，如果实在困难，可以谷歌

## 数据格式

### 请求的数据格式

* AFURLRequestSerialization

| 类型 | 说明 |
| -- | -- |
| `AFHTTPRequestSerializer` | 二进制的，默认的 |
| `AFJSONRequestSerializer` | JSON(POST JSON) RESTful 设计风格需要 |
| `AFPropertyListRequestSerializer` | PList(POST Plist－开发中几乎不用) |

### 响应数据格式

* `AFURLResponseSerialization`

| 类型 | 说明 |
| -- | -- |
| `AFHTTPResponseSerializer` | HTTP 二进制的 |
| `AFJSONResponseSerializer` | JSON 默认的 |
| `AFXMLParserResponseSerializer` | XML Parser 解析器 SAX 解析 |
| `AFXMLDocumentResponseSerializer` | (Mac OS X) XML DOM |
| `AFPropertyListResponseSerializer` |  PList 几乎不用 |
| `AFImageResponseSerializer` |  图像，不支持 GIF |
| `AFCompoundResponseSerializer` |  组合的 |

### 数据格式小结

* 大多情况下，都是 JSON，不需要指定
* XML 格式
    * 如果 `SAX` 解析，需要指定格式
```objc
mgr.responseSerializer = [AFXMLParserResponseSerializer serializer];
```
    * 然后利用代理方法解析

    * 如果 DOM 解析，需要指定格式
```objc
mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
```
    * 然后利用第三方框架解析

* 图像
    * AFN 支持图像缓存，也有对应的分类方法和 `SDWebImage` 非常像！
    * 但是：不支持 `GIF`


### 提示

* 使用 AFN 时，一定记住输出：`error`
* 如果 `state code == 200`，就是数据格式错误，针对具体格式进行设置即可


### 补充

以下连接是移动开发中，常见的 XML 数据格式

http://flash.weather.com.cn/wmaps/xml/china.xml
