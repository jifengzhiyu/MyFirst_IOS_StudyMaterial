# 重构

* 定义 `VideoXMLParser` 类专门负责 `XML` 解析
* 将 XML 解析相关代码移动至 `VideoXMLParser` 中
* 定义类方法

```objc
///  解析 Video XML 数据
///
///  @param parser   XML 解析器
///  @param finished 完成回调
+ (void)parserVideo:(NSXMLParser *)parser finished:(void (^)(NSArray *dataList))finished;
```

* 方法实现

```objc
+ (void)parserVideo:(NSXMLParser *)parser finished:(void (^)(NSArray *))finished {
    VideoXMLParser *obj = [[self alloc] init];

    obj.finishedBlock = finished;
    parser.delegate = obj;
    [parser parse];
}
```

* 方法调用

```objc
- (void)loadData {
    NSURL *url = [NSURL URLWithString:@"http://localhost/videos.xml"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:15.0];

    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];

        [VideoXMLParser parserVideo:parser finished:^(NSArray *dataList) {
            self.dataList = dataList;
        }];
    }];
}
```

