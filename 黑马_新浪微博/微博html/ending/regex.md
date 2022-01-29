# 正则表达式

有关正则表达式的参考文档链接：http://deerchao.net/tutorials/regex/regex.htm

## iOS 中的使用

* 正则表达式常用选项

    * `CaseInsensitive` 忽略大小写
    * `DotMatchesLineSeparators` `.` 匹配换行符

* 匹配方案
    * `.` 匹配任意字符
    * `*` 匹配 0~任意 多个字符
    * `?` 尽可能少的重复

* 匹配函数
    * `matchesInString`
        * 重复匹配多次 `pattern`
        * 如果匹配成功，生成 `NSTextCheckingResult` 数组
    * `firstMatchInString`
        * 匹配第一个 `pattern`
        * 如果匹配成功，生成 `NSTextCheckingResult`

* 匹配结果
    * `numberOfRanges`
        * 匹配的 `range` 计数
        * 如果匹配成功，是 `()` 的数量 `+ 1`
    * `rangeAtIndex`
        * `0` 和 `pattern` 完全匹配的内容
        * `1` 第一个 () 的内容
        * `2`...依次类推

    * 可以利用 `NSString` 的 `substringWithRange` 取得匹配结果

## 来源处理

* 新浪微博来源字符串格式

```
<a href=\"http://app.weibo.com/t/feed/310OQS\" rel=\"nofollow\">精彩微客</a>
```

> 目标：从一个 `html` 的 `href` 中提取 `链接文字 Link Text` 需要使用正则表达式

## 示例代码

```swift
let str = "aaa<a href=\"http://weibo.com/\" rel=\"nofollow\">微博 weibo.com</a>bbb"

let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
let regex = try! NSRegularExpression(pattern: pattern, options: [.CaseInsensitive])

guard let result = regex.firstMatchInString(str, options: [], range: NSRange(location: 0, length: str.characters.count)) else {
    return
}

let range1 = result.rangeAtIndex(1)
let range2 = result.rangeAtIndex(2)
let r1 = str.substringWithRange(str.startIndex.advancedBy(range1.location)..<str.startIndex.advancedBy(NSMaxRange(range1)))
let r2 = str.substringWithRange(str.startIndex.advancedBy(range2.location)..<str.startIndex.advancedBy(NSMaxRange(range2)))
print(r1)
print(r2)
```

## 建立分类

```swift
extension String {
    
    /// 提取字符串中的链接&文字
    ///
    /// - returns: (链接 文字) 元组
    func href() -> (link: String, text: String)? {
        
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        guard let result = regex.firstMatchInString(self,
            options: [],
            range: NSRange(location: 0, length: self.characters.count)) else {
                print("没有找到匹配内容")
                return nil
        }
        
        let str = self as NSString

        let r1 = result.rangeAtIndex(1)
        let link = str.substringWithRange(r1)
        let r2 = result.rangeAtIndex(2)
        let text = str.substringWithRange(r2)
        
        return (link, text)
    }
}
```

## 集成到微博项目

* 将分类拖拽至项目的 `Tools` 目录
* 修改 `Status` 模型

```swift
/// 微博来源
var source: String? {
    didSet {
        source = source?.href()?.text
    }
}
```

> 运行测试 :D
