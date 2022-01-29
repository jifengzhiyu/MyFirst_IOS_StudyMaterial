# 常用 HTTP 请求字段

* 常见请求字段

```bash
# 客户端要访问的服务器主机地址
Host: m.baidu.com

# 客户端的类型，客户端的软件环境
User-Agent: iPhone AppleWebKit

# 客户端所能接收的数据类型
Accept: text/html, */*

# 客户端的语言环境
Accept-Language: zh-cn

# 客户端支持的数据压缩格式
Accept-Encoding: gzip

# 访问结束后，是否断开连接
Connection: Close
```

## Range

* `Range` 用于设置获取服务器数据的范围
* 示例

| 值 | 说明 |
| -- | -- |
| bytes=500- | 从500字节以后的所有字节 |
| bytes=0-499 | 从0到499的头500个字节 |
| bytes=500-999 | 从500到999的第二个500字节 |
| bytes=-500 | 最后500个字节 |
| bytes=500-599,800-899 | 同时指定几个范围 |

* Range小结
    * `-` 用于分隔
        * 前面的数字表示起始字节数
        * 后面的数组表示截止字节数，没有表示到末尾
    * `,` 用于分组，可以一次指定多个Range，不过很少用

## Authorization

* `Authorization` 用于设置身份验证
* `BASIC` 身份验证数据格式

```
BASIC (用户名:口令)base64
```
