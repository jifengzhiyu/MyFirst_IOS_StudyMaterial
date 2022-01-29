# 表情键盘

> 在项目开发中，如果遇到相对独立而有特殊功能，可以新建一个项目演练，待演练完成后，再向项目中移植

## 整合到新浪微博

```swift
/// 表情键盘视图
private lazy var emoticonView: EmoticonView = EmoticonView { [weak self] (emoticon) -> () in
    self?.textView.insertEmoticon(emoticon)
}

/// 选择表情键盘
@objc private func selectEmoticon() {
    textView.resignFirstResponder()
    
    textView.inputView = textView.inputView == nil ? emoticonViewController.view : nil
    
    textView.becomeFirstResponder()
}
```

* 拖拽文件 `Emoticons.bundle`

## 三种拖拽文件夹的方式

* 黄色文件夹：编译后，资源文件在 `mainBundle` 中，源代码程序需要通过这种方式拖拽添加
    * 需要注意不能出现重名的文件
    * 效率高
* 蓝色文件夹：编译后，资源文件在 `mainBundle 中的对应文件夹`中，游戏文件的素材一般通过这种方式拖拽添加
    * 允许出现重名文件
    * 用于换肤应用
    * 效率略差
* 白色 Bundle：编译后，资源文件在 mainBundle 中仍然以`包`的形式存在，可以路径形式访问
    * 允许出现重名文件
    * 拖拽文件更简单
    * 主要用于第三方框架包装资源素材


