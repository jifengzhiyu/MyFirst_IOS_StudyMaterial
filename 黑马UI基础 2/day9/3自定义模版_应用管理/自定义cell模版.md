# 通过stroyboard中的cell模版加载单元格

- 不需要使用xib一个个加载单元格

- 直接在stroyboard里面拖拽一个UITableViewController

把identifer设定成ID

设置新的控制器.m .h文件，更改class

![image-20210920230120289](%E8%87%AA%E5%AE%9A%E4%B9%89cell%E6%A8%A1%E7%89%88.assets/image-20210920230120289.png)

只需要一句话

```objective-c
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
```

如果没有创建该单元格，就会自动创建，无需另外写判断语句

# 更改行高

**两个更改都要完成**

![image-20210920231549463](%E8%87%AA%E5%AE%9A%E4%B9%89cell%E6%A8%A1%E7%89%88.assets/image-20210920231549463.png)

![image-20210920231559483](%E8%87%AA%E5%AE%9A%E4%B9%89cell%E6%A8%A1%E7%89%88.assets/image-20210920231559483.png)

# 控件显示不出来的原因

![image-20210921130538124](%E8%87%AA%E5%AE%9A%E4%B9%89cell%E6%A8%A1%E7%89%88.assets/image-20210921130538124.png)

# 设置lable圆角显示

```objective-c
//设置lable圆角显示
    lblMsg.layer.cornerRadius = 5;
    lblMsg.layer.masksToBounds = YES;
```

# 弹窗的不固定问题

```objective-c
    //当前属于tableView控制器，弹窗会随着tableView滚动
    //[self.view addSubview:lblMsg];
    UIWindow *window =  [[[UIApplication sharedApplication] windows] objectAtIndex:0];
      [window addSubview:lblMsg];
```

# 总结

![image-20210921204359795](%E8%87%AA%E5%AE%9A%E4%B9%89cell%E6%A8%A1%E7%89%88.assets/image-20210921204359795.png)

![image-20210921204644463](%E8%87%AA%E5%AE%9A%E4%B9%89cell%E6%A8%A1%E7%89%88.assets/image-20210921204644463.png)

![image-20210921204746025](%E8%87%AA%E5%AE%9A%E4%B9%89cell%E6%A8%A1%E7%89%88.assets/image-20210921204746025.png)

 

![image-20210921204809795](%E8%87%AA%E5%AE%9A%E4%B9%89cell%E6%A8%A1%E7%89%88.assets/image-20210921204809795.png)

![image-20210921205042551](%E8%87%AA%E5%AE%9A%E4%B9%89cell%E6%A8%A1%E7%89%88.assets/image-20210921205042551.png)

 # kvc

![image-20210921205911561](%E8%87%AA%E5%AE%9A%E4%B9%89cell%E6%A8%A1%E7%89%88.assets/image-20210921205911561.png)

- 好处：灵活性增强

方便更改属性的名称

![image-20210921212042344](%E8%87%AA%E5%AE%9A%E4%B9%89cell%E6%A8%A1%E7%89%88.assets/image-20210921212042344.png)

```objective-c
        //展现灵活性
        //NSString *value = @"asasasa@qq.com";
        NSString *value = @"啊哈哈";
        //NSString *property = @"email";
        NSString *property = @"name";
        [p1 setValue:value forKeyPath:property];
        NSLog(@"%@------%@",p1.name,p1.email);
```

# 属性路径keyPath

```objective-c
 [p1 setValue:@"小狗狗" forKeyPath:@"dog.name"];
        //keyPath属性路径dog.name，可以这么点出来
```

# 对象转化词典

- 如果对象里面有的属性还是对象，那么对象转化成词典，就不会把作为属性的对象转化成词典，还是对象

```objective-c
//把一个对象转化成字典
        NSDictionary *dict = [p1 dictionaryWithValuesForKeys:@[@"name",@"age",@"email",@"dog"]];
        NSLog(@"%@",dict);
        NSLog(@"%@",[dict[@"dog"] class]);
        NSLog(@"%@",[dict[@"dog"] name]);
        //字典里面的dog键的值是一个狗对象
```

