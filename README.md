# NetworkCommunications

[![Author](https://img.shields.io/badge/Author-Jifengzhiyu-yellow.svg "Author:Jifengzhiyu")](https://github.com/jifengzhiyu "Author")

[![Domain](https://camo.githubusercontent.com/e23589a9defbfab129665df5f3b69547c56292a600f3dd1c67f04a82397951a5/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6d61696e2d494f532d627269676874677265656e2e737667)](https://camo.githubusercontent.com/e23589a9defbfab129665df5f3b69547c56292a600f3dd1c67f04a82397951a5/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6d61696e2d494f532d627269676874677265656e2e737667)

[![Language](https://camo.githubusercontent.com/1998aac702942519abbe9a9fbf21f32674f7f75f2e1e940c3c16b553f234f540/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f4c616e67756167652d4f626a656374697665432d626c756576696f6c65742e737667)](https://camo.githubusercontent.com/1998aac702942519abbe9a9fbf21f32674f7f75f2e1e940c3c16b553f234f540/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f4c616e67756167652d4f626a656374697665432d626c756576696f6c65742e737667) 

网络通信（Network Communications）学习资料，来自黑马IOS资料网络通信部分。

## 目录

#### day1

//1 概念

//2 URL HTTP

//3 请求百度  NSURLConnection -> NSURLRequest -> NSURL

//4 UIWebView

//5 使用浏览器监视请求

//6 网络模型

//7 Socket

//8 Socket的使用步骤 

//9 socket的基本演示

//10 模拟聊天

//11 使用Socket发送http请求

//12 请求头中的 User-Agent   connection

---

#### day2

//1 设置请求头，设置缓存策略，超时时长

//2 处理错误

//3 JSON -->  {"key":"value","k1":"v1"}  [{},{}]

//4 JSON解析

//5 数组输出汉字的问题  -- 新建NSArray的分类 重写descriptionWithLocale

//6 输出自定义对象中的数据   -- 重写自定义类的 description的getter方法

//7 JSON数据转换成模型

//8 网络模型中如果有数值类型 使用NSNumber

//9 Charles监视网络请求

//10 解析JSON的第三方框架演示 JSONKit

//11 PList的解析

//12 模拟科技头条

----

#### day3

//1 模拟科技头条，第二个自定义cell

//2 XML  可扩展标记语言

//3 解析XML

//4 模型属性使用copy


//5 get和post区别   

//6 通过URL传递数据的时候，如果数据中有汉字或空格  进行%转义

//7 Post 要设置request的HTTPMethod   HTTPBody

//8 练习 模拟登陆

//9 介绍加密解密

---

#### day4

//1 MD5 使用   不可逆的算法  指纹算法（摘要算法）

//2 MD5破解   -- 爆破

//3 MD5加盐

//4 钥匙串

//5 重构代码

//6 自动登陆


//7 HTML  --> form 表单

//8 上传文件的原理 （通过浏览器监视上传文件的请求）

//9 上传单个文件   

//10 上传多个文件

//11 代码重构（封装上传单个文件和多个文件）

//12 RESTful

//13 JSON序列化

//14 把JSON保存到文件中

----

#### day5

//1 Head请求  -- 获取响应头

//2 nil  NULL  NSNull

//3 **作为参数  输出参数

//4 下载-->get请求  - 没有进度提示，内存会暴涨

//5 解决没有进度提示

//6 解决内存暴涨--一点一点保存文件     读写文件

//7 FileManager -- 创建、复制、删除、判断文件是否存在

//8 断点续传

//9 断点续传--服务器文件的信息 （大小和名称-路径）

//10 断点续传--获取本地文件的信息，和服务器文件比较  

//11 断点续传--从指定位置开始下载

//12 下载进度提示  -- 控件

//13 取消（暂停下载）

//14 下载操作管理类  -- 下载操作缓存池--解决了重复下载的问题

//15 暂停操作

//16 把downloader改成自定义Operation

-----

#### day6

//1 NSURLSession 介绍

//2 任务

//3 downloadDelegate 获取下载进度--如果使用代理不能使用回调

//4 上传进度

//5 delete 请求   /  下载图片，显示

//6 Session的代理的循环引用的问题---使session无效

//7 configuration  全局设置

//8 AFN介绍

//9 封装connection的类  get  post  上传文件

//10 封装session的类  get  post  上传文件  下载文件-进度

//11 Serialization

----

#### day7

//1 创建项目  cocoaPods 管理第三方框架

//2 创建了操作网络的工具类 HMNetworkTools

//3.1 创建模型类型，加载网络数据, 测试

//3.2 设置collectionView数据源方法， 横向滚动

//3.3 自定义cell，显示图片和标题

//3.4 无限轮播的思路

//3.5 当collectionView的数据加载完毕，滚动到第二个cell

//3.6 返回cell之前，计算当前要显示的图片的索引

//3.7 当滚动结束之后，计算currentIndex当前图片的索引，滚动到第二个cell

//4 containerView加载图片轮播器的控制器，在viewDidLayoutSubviews中设置cell的大小，否则collectionView的大小不合适

//5 设置网络加载指示符和缓存

//6.1 异步加载新闻数据，测试，解决问题

//6.2 自定义cell

//6.3 大图cell

//6.4 三个图片的cell

//7.1 homeController --》scrollView  和 collectionView

-----

#### day8

//7.2 加载新闻分类的数据

//7.3 显示新闻分类的数据，自定义label

//7.4 自定义cell中加载另一个控制器的controller中的view

- webView



## 相关链接
