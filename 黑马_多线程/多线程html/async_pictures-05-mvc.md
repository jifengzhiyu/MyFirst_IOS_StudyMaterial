# MVC

## 在模型中添加 `image` 属性

```objc
#import <UIKit/UIKit.h>

///  下载的图像
@property (nonatomic, strong) UIImage *image;
```

## 使用 MVC 更新表格图像

* 判断模型中是否已经存在图像
```objc
if (app.image != nil) {
    NSLog(@"加载模型图像...");
    cell.iconView.image = app.image;
    return cell;
}
```

* 下载完成后设置模型图像

```objc
// 3. 主线程更新 UI
[[NSOperationQueue mainQueue] addOperationWithBlock:^{
    // 设置模型中的图像
    app.image = image;
    // 刷新表格
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}];
```

## 问题

* 如果图像下载很慢，用户滚动表格很快，会造成重复创建下载操作

* 修改延时代码

```objc
// 1. 模拟延时
if (indexPath.row == 0) {
    [NSThread sleepForTimeInterval:10.0];
}
```

快速滚动表格，将第一行不断“滚出/滚入”界面可以查看操作被重复创建的问题

## 解决办法

* 操作缓冲池
