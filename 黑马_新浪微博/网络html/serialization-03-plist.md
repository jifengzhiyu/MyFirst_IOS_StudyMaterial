# PList解析

> `PList` 主要在苹果开发中常用，很多后台并不会返回 `PList` 的数据格式，有关 `Plist` 的反序列化知道即可

```objc
/**
 参数

 1. data:   要反序列化的二进制数据
 2. option: 选项，位移枚举类型
     NSPropertyListImmutable = 0,                   不可变
     NSPropertyListMutableContainers = 1,           容器可变
     NSPropertyListMutableContainersAndLeaves = 2   容器和叶子可变
 3. format: 如果不希望知道格式，传入 NULL 即可
 4. error:  错误
 */
id result = [NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:NULL];
```

| 选项 | 说明 |
| -- | -- |
| `NSPropertyListImmutable = 0` | 不可变 |
| `NSPropertyListMutableContainers = 1` | 容器可变 |
| `NSPropertyListMutableContainersAndLeaves = 2` | 容器和叶子可变 |

* `format`: 如果不需要格式，传入 `NULL`
