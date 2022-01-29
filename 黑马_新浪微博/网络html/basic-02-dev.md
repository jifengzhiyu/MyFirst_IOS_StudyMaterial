# 开发方案

在iOS中，常见的发送HTTP请求的方案包括：

* 苹果官方

| 名称 | 说明 |
| -- | -- |
| `NSURLConnection` | iOS 2.0 推出，用法简单，最古老最经典最直接的一种方案 |
| `NSURLSession` | iOS 7 推出，功能比 NSURLConnection 更加强大 |
| `CFNetwork` | NSURL 的底层，纯C语言，几乎不用 |

* 第三方框架

| 名称 | 底层 | 说明 |
| -- | -- | -- |
| `ASIHttpRequest` | `CFNetwork` | 外号`HTTP终结者`，功能极其强大，2012年 10 月停止更新，MRC |
| `AFNetworking` | `NSURLConnection` & `NSURLSession` | 简单易用，提供了基本够用的常用功能，维护和使用者多 |
| `MKNetworkKit` | `NSURLConnection` | 简单易用，产自三哥的故乡印度，维护和使用者少 |
| `Alamofire` | `NSURLSession` | `MATTT` 的又一力作，Swift 开发，轻量级的 HTTP 解决方案，目前功能还远不如 `AFNetworking` |
