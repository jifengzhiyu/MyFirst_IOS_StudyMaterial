# 暂停下载

# 暂停下载

```objc
- (void)pause {
    [self.conn cancel];
}
```

* Cancels an asynchronous load of a request.
After this method is called, the connection makes no further delegate method calls. If you want to reattempt the connection, you should create a new connection object.

* 取消一个异步请求，调用此方法后，`connection`不会再调用代理方法。如果要再次尝试连接，需要建立一个新的连接对象
