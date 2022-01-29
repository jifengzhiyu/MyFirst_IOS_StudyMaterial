# XML 解析

```objc
// 1. 开始文档 - 准备工作
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"1. 开始文档");
    [self.videos removeAllObjects];
}

// 2. 开始节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    NSLog(@"2. 开始节点 %@ %@", elementName, attributeDict);

    if ([elementName isEqualToString:@"video"]) {
        // 如果是 video 节点，新实例化一个 video 对象
        self.currentVideo = [[Video alloc] init];

        // 设置 videoId 属性
        self.currentVideo.videoId = @([attributeDict[@"videoId"] integerValue]);
    }
    // 清空字符串
    [self.elementString setString:@""];
}

// 3. 发现文字
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"==> %@", string);
    [self.elementString appendString:string];
}

// 4. 结束节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"4. 结束节点 %@", elementName);

    if ([elementName isEqualToString:@"video"]) {
        // 如果是 video 节点，说明一个节点解析完成，将 currentVideo 添加到数组
        [self.videos addObject:self.currentVideo];
    } else if (![elementName isEqualToString:@"videos"]) {
        // 如果不是 videos 节点，说明是 video 的属性节点，利用 KVC 设置数值
        [self.currentVideo setValue:self.elementString forKey:elementName];
    }
}
// 5. 结束文档 - 解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"5. 解析结束");
    NSLog(@"%@ %@", self.videos, [NSThread currentThread]);
}
```

