# 绑定表格

## 数据源

### 定义属性

```objc
///  表格的数据源数组
@property (nonatomic, strong) NSArray *dataList;
```

### setter方法

```objc
- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;

    [self.tableView reloadData];
}
```

### 数据源方法

```objc
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    // 设置 Cell...
    cell.textLabel.text = [self.dataList[indexPath.row] name];

    return cell;
}
```

### 设置数据源方法

```objc
// 5. 结束文档 - 解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"5. 解析结束");
    NSLog(@"%@ %@", self.videos, [NSThread currentThread]);

    dispatch_async(dispatch_get_main_queue(), ^{
        self.dataList = self.videos;
    });
}
```

## 自定义 Cell
