# Socket 加载百度

* 修改接收函数

```objc
- (NSString *)sendAndRecv:(NSString *)msg {
    // 1. 发送
    ssize_t sendLen = send(self.clientSocket, msg.UTF8String, strlen(msg.UTF8String), 0);
    NSLog(@"发送 %ld %tu %ld", sendLen, msg.length, strlen(msg.UTF8String));

    // 2. 接收
    uint8_t buffer[1024];
    NSMutableData *dataM = [NSMutableData data];
    ssize_t recvLen = -1;

    while (recvLen != 0) {
        recvLen = recv(self.clientSocket, buffer, sizeof(buffer), 0);

        [dataM appendBytes:buffer length:recvLen];
    }
    NSString *result = [[NSString alloc] initWithData:dataM encoding:NSUTF8StringEncoding];

    // 3. 断开连接
    [self disconnect];

    return result;
}
```

* 发送请求

```objc
- (void)viewDidLoad {
    [super viewDidLoad];

    if (![self connectToHost:@"61.135.185.17" port:80]) {
        NSLog(@"连接失败");
        return;
    }

    // 发送请求
    NSString *request = @"GET / HTTP/1.1\r\n"
    "Host: m.baidu.com\r\n"
    "User-Agent: iPhone AppleWebKit\r\n"
    "Connection: Close\r\n\r\n";
    NSString *resposne = [self sendAndRecv:request];

    // 获取 html
    NSRange range = [resposne rangeOfString:@"\r\n\r\n"];
    if (range.location != NSNotFound) {
        NSString *html = [resposne substringFromIndex:range.location + range.length];

        [self.webView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://m.baidu.com"]];
    } else {
        NSLog(@"加载失败");
    }
}
```
