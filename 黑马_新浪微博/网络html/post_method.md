# POST增强

## POST 常用方法 - `ContentType`

* `application/x-www-form-urlencoded`
    * 主要向服务器提交用户隐私相关的信息
    * 浏览器支持
* `multipart/form-data`
    * 向服务器上传小文件
    * 浏览器支持
* `application/json`
    * 向后台服务器提交结构化数据
    * `RESTful` 设计风格需要
* `text/xml`
    * 向后台服务器提交结构化数据
    * `RESTful` 设计风格需要


## 文件上传

据工作的同学反馈，经常有人会咨询上传文件的原理，并且反馈第三方框架 `AFNetworking` 在处理有些文件上传时无法胜任！

文件上传的原理只需要理解即可，工作中可以直接 `cmd+c` & `cmd+v`
