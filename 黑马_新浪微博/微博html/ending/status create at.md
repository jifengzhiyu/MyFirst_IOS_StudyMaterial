# 微博时间

# 日期处理

## 新浪微博日期格式

```
Tue Sep 15 12:12:00 +0800 2015
星期 月 日 时:分:秒 时区 年
```

> 要从一个字符串中解析得到准确的时间，必须要指定`正确的格式字符串`，以及对应的`时区标示`

## 日期格式

* 年
    * `y` 将年份 (0-9) 显示为不带前导零的数字
    * `yy` 以带前导零的两位数字格式显示年份
    * `yyy` 以四位数字格式显示年份
    * `yyyy` 以四位数字格式显示年份
* 月
    * `M` 将月份显示为不带前导零的数字（如一月表示为 1）
    * `MM` 将月份显示为带前导零的数字（例如 01/12/01）
    * `MMM` 将月份显示为缩写形式（例如 Jan）
    * `MMMM` 将月份显示为完整月份名（例如 January）
        * 一月 Jan January
        * 二月 Feb February
        * 三月 Mar March
        * 四月 Apr April
        * 五月 May May
        * 六月 Jun June
        * 七月 Jul July
        * 八月 Aug August
        * 九月 Sep September
        * 十月 Oct October
        * 十一月 Nov November
        * 十二月 Dec December

* 日
    * `d` 将日显示为不带前导零的数字（如 1）
    * `dd` 将日显示为带前导零的数字（如 01）
* 星期
    * `EEE` 将日显示为缩写形式（例如 Sun）
    * `EEEE` 将日显示为全名（例如 Sunday）
        * 星期一 Mon Monday
        * 星期二 Tue Tuesday
        * 星期三 Wed Wednesday
        * 星期四 Thu Thursday
        * 星期五 Fri Friday
        * 星期六 Sat Saturday
        * 星期天 Sun Sunday
* 小时
    * `h` 使用 12 小时制将小时显示为不带前导零的数字（例如 1:15:15 PM）
    * `hh` 使用 12 小时制将小时显示为带前导零的数字（例如 01:15:15 PM）
    * `H` 使用 24 小时制将小时显示为不带前导零的数字（例如 1:15:15）
    * `HH` 使用 24 小时制将小时显示为带前导零的数字（例如 01:15:15）
* 分钟
    * `m` 将分钟显示为不带前导零的数字（例如 12:1:15）
    * `mm` 将分钟显示为带前导零的数字（例如 12:01:15）
* 秒
    * `s` 将秒显示为不带前导零的数字（例如 12:15:5）
    * `ss` 将秒显示为带前导零的数字（例如 12:15:05）
    * `f` 显示秒的小数部分
    * `ff` 将精确显示到百分之一秒
    * `ffff` 将精确显示到万分之一秒
    * 用户定义格式中最多可使用七个 f 符号
* 上午&下午
    * `t` 使用 12 小时制
        * 中午之前任一小时显示大写的 A
        * 中午到 11:59 PM 之间的任一小时显示大写的 P
    * `tt` 对于使用 12 小时制的区域设置
        * 中午之前任一小时显示大写的 AM
        * 中午到 11:59 PM 之间的任一小时显示大写的 PM
    * 对于使用 24 小时制的区域设置，不显示任何字符
* 时区
    * `z` 显示不带前导零的时区偏移量
    * `zz` 显示带前导零的时区偏移量（例如 -08）
    * `zzz` 显示完整的时区偏移量（例如 -0800）
* 纪元
    * `gg` 显示时代/纪元字符串（例如 A.D.）


## 日期转换测试代码

```swift
var create_date = "Tue Sep 15 12:12:00 +0800 2015"
let df = NSDateFormatter()
df.locale = NSLocale(localeIdentifier: "en")
df.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
let date = df.dateFromString(create_date)
```

## 日期需求

* 刚刚(一分钟内)
* X分钟前(一小时内)
* X小时前(当天)
* 昨天 HH:mm(昨天)
* MM-dd HH:mm(一年内)
* yyyy-MM-dd HH:mm(更早期)

### 日期分类

* 建立 `Date+Extension.swift`
* 抽取类函数创建日期

```swift
/// 把新浪微博日期格式的字符串转换成日期
class func sinaDate(str: String) -> NSDate? {
    let df = NSDateFormatter()
    df.locale = NSLocale(localeIdentifier: "en")
    df.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
    
    return df.dateFromString(str)
}
```

* 由于微博显示日期时随时更新的，因此建立一个函数单独处理日期描述

* 准备函数如下：

```swift
/// 日期描述字符串
///
/// 格式如下
///     -   刚刚(一分钟内)
///     -   X分钟前(一小时内)
///     -   X小时前(当天)
///     -   昨天 HH:mm(昨天)
///     -   MM-dd HH:mm(一年内)
///     -   yyyy-MM-dd HH:mm(更早期)
var dateDescription: String {
    return "日期"
}
```

> 在 iOS 中处理日期的详细信息需要借助到 `NSCalendar` 类，`NSCalendar` 提供了非常丰富的日期操作函数

* 日期分段判断

```swift
/// 日期描述字符串
var dateDescription: String {

    // 1. 获取当前日历
    let calendar = NSCalendar.currentCalendar()

    // 2. 判断当前日期
    if calendar.isDateInToday(self) {
        return "今天"
    }

    // 3. 其他日期
    if calendar.isDateInYesterday(self) {
        return "昨天"
    }

    return "其他"
}
```

* 测试数据

```swift
print(NSDate.sinaDate("Tue Sep 15 12:12:00 +0800 2015")?.dateDescription)
print(NSDate.sinaDate("Tue Sep 14 12:12:00 +0800 2015")?.dateDescription)
print(NSDate.sinaDate("Tue Sep 12 12:12:00 +0800 2015")?.dateDescription)
print(NSDate.sinaDate("Tue Sep 15 12:12:00 +0800 2014")?.dateDescription)
print(NSDate.sinaDate("Tue Sep 14 12:12:00 +0800 2014")?.dateDescription)
```

* 日历函数

```swift
canlendar.components(.Year, fromDate: self)
```

* 比较两个日期

```swift
let coms = calendar.components(.Year, fromDate: self, toDate: NSDate(), options: [])

print(coms.year)
```

* 计算非今天的日期信息

```swift
var fmt = " HH:mm"
if calendar.isDateInYesterday(self) {
    fmt = "昨天" + fmt
} else {
    fmt = "MM-dd" + fmt
    
    // 更早期
    if (calendar.components(.Year, fromDate: self, toDate: NSDate(), options: [])).year > 0 {
        fmt = "yyyy-" + fmt
    }
}

let df = NSDateFormatter()
df.locale = NSLocale(localeIdentifier: "en")
df.dateFormat = fmt

return df.stringFromDate(self)
```

* 计算今天的日期信息

```swift
// 1. 今天
if calendar.isDateInToday(self) {
    let delta = Int(NSDate().timeIntervalSinceDate(self))
    
    if delta < 60 {
        return "刚刚"
    }
    if delta < 3600 {
        return "\(delta / 60) 分钟前"
    }
    return "\(delta / 3600) 小时前"
}
```

## 集成日期处理

* 将分类拖拽至项目的 `Tools` 目录
* 在 `StatusViewModel` 中增加计算型属性

```swift
/// 微博创建时间
var createAt: String? {
    return NSDate.sinaDate(status.created_at ?? "")?.dateDescription
}
```

* 在 `StatusCellTopView` 中设置显示日期

```swift
timeLabel.text = statusViewModel?.createAt
```

> 运行测试:D

