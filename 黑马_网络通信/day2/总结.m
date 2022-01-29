//1 设置请求头，设置缓存策略，超时时长
//2 处理错误
//3 JSON -->  {"key":"value","k1":"v1"}  [{},{}]
//4 JSON解析
    //JSON的序列化   把OC对象转换成JSON形式的字符串
    //JSON的反序列化  JSON形式的字符串转换成OC对象（数组或字典）

//5 数组输出汉字的问题  -- 新建NSArray的分类 重写descriptionWithLocale
//6 输出自定义对象中的数据   -- 重写自定义类的 description的getter方法
//7 JSON数据转换成模型

//8 网络模型中如果有数值类型 使用NSNumber
//9 Charles监视网络请求
//10 解析JSON的第三方框架演示 JSONKit
//11 PList的解析
//12 模拟科技头条
    //1 获取网络数据
    //2 tableView中展示数据 注意 异步
    //3 下拉更新
    //4 重构代码（把异步获取模型数据的代码封装到模型中）
    //5 自定义cell
    //6 如果标题有两行的话 隐藏summaryView
    //7 时间的处理