//1 模拟科技头条，第二个自定义cell
//2 XML  可扩展标记语言
//3 解析XML
    //SAX  速度快，只读   NSXMLParser
        //加载xml文档
        //找开始节点
        //找节点之间的内容
        //找结束节点
        //解析完毕
    //DOM  速度慢，读写  第三方框架 GData
        //文档对象模型(文档🌲模型)

//4 模型属性使用copy




//get的请求头



//post的请求头
Content-Length: 25   //发送服务器数据的大小
Cache-Control: max-age=0   //永不缓存数据
Content-Type: application/x-www-form-urlencoded   //请求头中的Content-Type
//告诉服务器，发给服务器的数据格式和url中传参的格式是一样的   key=value&k1=v1


//5 get和post区别
    //get  速度快，不安全。 获取数据，传输少量的数据，不适合传输密码等隐私数据
    //post 速度慢，相对安全。提交数据，传输大量数据，或隐私数据

//6 通过URL传递数据的时候，如果数据中有汉字或空格  进行%转义

//7 Post 要设置request的HTTPMethod   HTTPBody


//8 练习 模拟登陆
    //8.1 发送post请求
    //8.2 登陆成功后，把账号密码存储到沙盒
    //8.3 base64
    //8.4 base64原理   base64编码 作用把任意二进制数据转换成字符串，在网络上传输
//9 介绍加密解密
    //9.1 什么是加密
    //9.2 对称加密 DES  3DES AES
    //9.3 非对称加密  RSA
    //9.4 散列算法 MD5、SHA1、SHA256、SHA512
    //9.5 经常使用非对称加密 对对称加密的秘钥进行加密


