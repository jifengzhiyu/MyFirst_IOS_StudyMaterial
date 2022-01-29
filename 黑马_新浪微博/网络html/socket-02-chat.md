# Socket 聊天

* 搭建界面
* 自动布局 & 代码连线

```objc
///  主机地址
@property (weak, nonatomic) IBOutlet UITextField *hostName;
///  端口号
@property (weak, nonatomic) IBOutlet UITextField *portNumber;
///  发送消息文字
@property (weak, nonatomic) IBOutlet UITextField *messageText;
///  接收文字标签
@property (weak, nonatomic) IBOutlet UILabel *recvLabel;
///  发送按钮
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
```

* 调整连接到主机代码，添加参数

```objc
/// 连接
- (BOOL)connectToHost:(NSString *)hostName port:(int)port {

    // 1. socket
    self.clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    NSLog(@"%d", self.clientSocket);

    // 2. 连接
    struct sockaddr_in serverAddr;
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_addr.s_addr = inet_addr(hostName.UTF8String);
    serverAddr.sin_port = htons(port);

    return connect(self.clientSocket, (const struct sockaddr *)&serverAddr, sizeof(serverAddr)) == 0;
}
```

* 实现连接功能

```objc
- (IBAction)connect {
    BOOL result = [self connectToHost:self.hostName.text port:self.portNumber.text.intValue];
    self.sendButton.enabled = result;
    self.recvLabel.text = result ? @"成功" : @"失败";
}
```

* 调整发送和接收方法，添加参数

```objc
///  发送和接收
- (NSString *)sendAndRecv:(NSString *)msg {
    // 1. 发送
    ssize_t sendLen = send(self.clientSocket, msg.UTF8String, strlen(msg.UTF8String), 0);
    NSLog(@"发送 %ld %tu %ld", sendLen, msg.length, strlen(msg.UTF8String));

    // 2. 接收
    uint8_t buffer[1024];
    ssize_t recvLen = recv(self.clientSocket, buffer, sizeof(buffer), 0);
    NSLog(@"接收了 %ld %ld", recvLen, sizeof(buffer));
    NSString *result = [[NSString alloc] initWithBytes:buffer length:recvLen encoding:NSUTF8StringEncoding];

    return result;
}
```

* 发送和接收操作

```objc
- (IBAction)send {
    self.recvLabel.text = [self sendAndRecv:self.messageText.text];
}
```
