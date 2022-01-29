![image-20210914170506088](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210914170506088.png)

# 文件分类

M model：模型

V view :控件

C controller：控制器

# xib自定义单元格

![image-20210914211217478](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210914211217478.png)

创建.m .h控制器文件

![image-20210914211933269](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210914211933269.png)

![image-20210914212019039](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210914212019039.png)

在xib里面

![image-20210914220146306](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210914220146306.png)

相当于这个单元格的id

# 改进

![image-20210914221515110](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210914221515110.png)

改成红色

解耦

![image-20210914221614723](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210914221614723.png)

# 步骤

- 仅供参考，实际以代码为准

![image-20210915084612553](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210915084612553.png)

![image-20210915084805199](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210915084805199.png)

![image-20210915084903273](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210915084903273.png)

![image-20210915085228984](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210915085228984.png)

- xib中cell单元格里的子控件都统一归ocontentView管理

![image-20210915085438506](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210915085438506.png)

# 有关UITableView的footerView

```objective-c
 //设置UITableView的footerView
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.backgroundColor = [UIColor systemPinkColor];
    btn.frame = CGRectMake(50, 60, 70, 80);
    //证明UITableView的footerView：只能修改X,H的值
    self.tableView.tableFooterView = btn;
```

# 有个xib里面view的尺寸更改问题

![image-20210915090644434](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210915090644434.png)

想要更改尺寸，必须设置freeform

# view的隐藏

![image-20210915092740631](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210915092740631.png)

# 让等待圈圈转起来

![image-20210915160302817](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210915160302817.png)

# 代理

自己做不了的事情，看谁能做，就让谁做，让它当代理

自己发布一个协议，让代理遵守这个协议

![image-20210915161913473](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210915161913473.png)

把代理协议写在头文件里面

代理协议名称：委托代理控件名称加上Delegate

规范：**代理协议里的方法以代理协议名称开头，必须有一个参数（控件自己）**

![image-20210915164231060](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210915164231060.png)

- 调用代理方法之前，要确保代理对象已经实现了这个代理方法
- ![image-20210915164628858](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210915164628858.png)

# 等待一段时间执行代码块

![image-20210915172903442](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210915172903442.png)

# 加载xib另外的方法

![image-20210915213328828](%E8%87%AA%E5%AE%9A%E4%B9%89cell.assets/image-20210915213328828.png)

