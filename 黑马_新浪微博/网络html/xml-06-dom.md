# GData 解析 XML

## SAX & DOM 解析对比

* SAX 解析特点
	* 只读
	* 从上向下
	* 速度快
	* 解析的时候相对比较繁琐，有5个代理方法，每个代理方法都要写一定代码
	* 适合大的 XML 文件解析

在计算机领域，针对 XML 解析，还有 `DOM` 解析方式，在 PC 端和服务器端被广泛使用

* 背景
	* 主要用在 PC 端或者服务器端
	* 苹果提供了 `NSXML` 类支持 `DOM` 方式的解析
	* 不过 `NSXML` 类只能用在 `MAC` 开发，在 `iOS` 中无法直接使用

* DOM 特点
	* DOM 方式不仅能解析 XML 文档，还能够修改: 增加节点／删除节点
	* 一次性将 XML 文档以树形结构读入内存
	* 横向的节点越多，内存消耗越大
	* 使用 DOM 解析适合于小的 XML 解析，并且能够动态维护
	* 有些第三方框架就提供了 DOM 方式的解析，`GData`／`KissXML`(XMPP)
	* 在 iOS 开发中，**如果要使用 DOM 方式解析，最好只处理小的 XML**


## 使用 GData 解析的小结

* 使用第三方框架解析 XML 仍然会有些繁琐，原因就是因为 XML 的格式非常复杂
* 步骤，导入框架的，可以参见 .h 头文件，一共设置两个地方

```objc
// libxml includes require that the target Header Search Paths contain
//
//   /usr/include/libxml2
//
// and Other Linker Flags contain
//
//   -lxml2
```

* 获得根节点，依次 Log，一定要确认能够拿到所有子节点的内容
* 横向节点越多，for的层次就越深
* 根据实际的 XML 的情况，确认解析，基本上通过 KVC 就能够实现快速的解析
