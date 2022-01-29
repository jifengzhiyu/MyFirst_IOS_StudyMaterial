# 加载 XML 数据

## loadData

```objc
- (void)loadData {

    NSURL *url = [NSURL URLWithString:@"http://localhost/videos.xml"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    // 异步解析 XML
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        // 1. 使用网络返回的二进制数据实例化 NSXMLParser 对象
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        // 2. 设置代理，通过代理方法实现 SAX 解析
        parser.delegate = self;

        // 3. 开始解析
        [parser parse];
    }];
}
```

## 代理方法 - 添加 Log 确认思路

```objc
// MARK: - NSXMLParserDelegate
// 1. 开始文档 - 准备工作
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"1. 开始文档");
}

// 2. 开始节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    NSLog(@"2. 开始节点 %@ %@", elementName, attributeDict);
}

// 3. 发现文字
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"==> %@", string);
}

// 4. 结束节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"4. 结束节点 %@", elementName);
}
// 5. 结束文档 - 解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"5. 解析结束");
}

// 6. 错误处理
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"解析错误 %@", parseError);
}
```

## 整理思路，确定素材

### video 模型

```objc
@interface Video : NSObject

///  视频代号
@property (nonatomic, copy) NSNumber *videoId;
///  视频名称
@property (nonatomic, copy) NSString *name;
///  视频长度
@property (nonatomic, copy) NSNumber *length;
///  视频URL
@property (nonatomic, copy) NSString *videoURL;
///  图像URL
@property (nonatomic, copy) NSString *imageURL;
///  介绍
@property (nonatomic, copy) NSString *desc;
///  讲师
@property (nonatomic, copy) NSString *teacher;

+ (instancetype)videoWithDict:(NSDictionary *)dict;

@end
```

### 确定素材

```objc
///  目标模型数组
@property (nonatomic, strong) NSMutableArray *videos;
///  当前解析对象
@property (nonatomic, strong) Video *currentVideo;
///  拼接字符串
@property (nonatomic, strong) NSMutableString *elementString;
```

#### 懒加载

```objc
// MARK: - 懒加载
- (NSMutableArray *)videos {
    if (_videos == nil) {
        _videos = [[NSMutableArray alloc] init];
    }
    return _videos;
}

- (NSMutableString *)elementString {
    if (_elementString == nil) {
        _elementString = [[NSMutableString alloc] init];
    }
    return _elementString;
}
```
