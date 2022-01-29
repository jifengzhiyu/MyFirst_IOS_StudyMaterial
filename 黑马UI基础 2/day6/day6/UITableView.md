# UITableView表格控件

- 表格：按照行和列的方式来显示内容（数据，控件等等）

**多行，但是只有一列**

- ```
  @interface UITableView : UIScrollView
  ```

UITableView继承UIScrollView

- 两种样式：

UITableViewStylePlain

UITableViewStyleGrouped 分组数据

![image-20210911194004134](UITableView.assets/image-20210911194004134.png)

# 如果展示数据

![image-20210911173532582](UITableView.assets/image-20210911173532582.png)

![image-20210911165527435](UITableView.assets/image-20210911165527435.png)

![image-20210911172145003](UITableView.assets/image-20210911172145003.png)

- **数据源对象一般都是当前控制器，即self**
- 设置数据源对象的两种方式

1、代码

2、拖线

![image-20210911172711415](UITableView.assets/image-20210911172711415.png)

