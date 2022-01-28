#pragma mark 源代码管理工具介绍
// SVN : 集中式版本管理工具
// Git : 分布式版本管理工具

#pragma mark SVN介绍
// checkout: 下载代码, 只需要做一次
// update : 更新代码
// commit :提交代码

#pragma mark 服务器搭建
// 端口号
// http 80 一般是http, 因为SVN一般都是公司内部才能访问
// https 443

// 新建文件夹
// 每次对服务器端做操作, 版本号都会提升

// 模拟器桥接模式 (√)

// 192.168.xx.xx (√)
// (运行 --> cmd --> ipconfig --> 获取192.168.xx的地址)

http: //192.168.12.103/svn/weibo/

#pragma mark 常见命令行工具
// pwd : 查看当前目录

// cat : 在命令行中查看文件

// ls : 查看文件

// touch : 创建
// 注意：touch不修改myfile.txt内容，只更改它的访问、修改时间，如果myfile.txt不存在，它会被创建
//如果已经存在，就不会再被创建

// more : 分页查看文件内容(f,b)

#pragma mark SVN基本命令
// svn checkout // 检出 下载
// svn checkout http://192.168.1.107/svn/wechat --username=jingli --password=jingli

// svn status // 查看状态

// svn add // 添加某个文件进行管理
// svn add a.h

// svn commit // 提交代码
// svn commit -m "这里写message"

// svn update // 更新代码

// svn help // 帮助

// svn log // 查看之间的记录

// svn resolved // 告诉系统已经解决好了冲突
// svn resolved Car.h

#pragma mark SVN基本使用
// 0.新建一个文件夹
// 1.checkout 建立连接
// 2.进入对应的目录创建文件
// 3.add
// 4.提交并且输入账户

#pragma mark SVN基本命令的简写
// checkout : svn co
// status : svn st
// commit : svn ci
// update : svn up

#pragma mark 文件状态介绍
// ? : 文件在SVN管理的目录下, 但是没有被SVN所管理. 看见? , 记得add
// A : 文件在SVN管理的目录下, 并且, 已经被本地SVN版本库管理, 看见A, 记得commit
// D : 文件在本地删除, 还需要提交
// M : 文件在本地被修改过, 需要提交
// G : 文件曾经发生过冲突, 然后被解决了
// U : 文件被更新
// C : 文件发生了冲突

#pragma mark 常见问题
// 1. is not a working copy : 说明没有进入到SVN管理的目录. 就进行了SVN的命令. 应该进入到正确目录

// 2. xcrun: error: active developer path ("/Applications/Xcode 2.app/Contents/Developer") does not exist, use `xcode-select --switch path/to/Xcode.app` to specify the Xcode that you wish to use for command line developer tools (or see `man xcode-select`)
// 解决方案: 当多个Xcode版本同时存在, 可能工具就混乱了. 需要选择一下. 找Xcode --> 偏好设置 --> Locations --> command line 选择一下即可

// 3.  is out of date : 文件过期 . 如果发生了冲突, 那么直接提交时, 会报此错误. 应该update.

// 4.Could not use external editor to fetch log message; consider setting the $SVN_EDITOR environment variable or using the --message (-m) or --file (-F) options
//  需要添加一个 message

// 5.Authentication realm: <http://192.168.12.103:80> VisualSVN Server
// 权限 可能用户名或密码错误

#pragma mark 注意事项
// 1. 先更新, 再提交. (不会覆盖掉刚刚写的代码, 因为修改的文件版本高于服务器版本, 不会被覆盖.) 可以检测到冲突, 这只是一个操作规范.
//写完一个小功能就去提交
// 2. 每一个文件都有单独的版本号, 24 - 25
// 3. 及时提交, 没做完一个小板块, 或者一个小功能就提交. 避免冲突
// 4. 如何避免冲突:  分模块, 沟通 .

#pragma mark 如何解决冲突
// ---1. 代码冲突: 同一个文件, 同一行, 两个不同的人修改并提交. 就会发生冲突

// ---2. 更新时, 如果发生冲突时会报以下错误
// Conflict discovered in '/Users/apple/Desktop/SVN演练/八戒/Weixin/Car.h'.
// --常用
//(p) postpone : 延迟处理(svn工具不会帮你做解决冲突的事情, 自己手动解决) (版本会发生改变, 所以解决完冲突需要提交)
//(mf) mine-conflict : 使用我的代码, 覆盖服务器的代码 . 还需要提交一次 (版本会发生改变, 所以需要提交)
//(tf) theirs-conflict : 使用服务器的代码(他们的), 丢弃我的代码 (版本不会发生改变)
// --不常用
// (s) show all options : 展示所有的选项
// (df) diff-full : 展示所有不同
// (e) edit : 编辑, 在命令行中编辑

// ---3. 发生冲突的文件会发生改变
//<<<<<<< .mine ~  ======= 我的代码
//======= ~ >>>>>>> .r24  服务器的代码

// ---4. 解决冲突的方案:
// 1. (建议)选p, 延迟解决
// 2. 删除不认识的代码(<< == >> ), 然后自己合并代码
// 3. 告诉本地版本库, 自己已经解决了冲突: svn resolved Car.h
// 4. 需要提交代码 (其它人更新即可)

#pragma mark 使用第三方图形化工具(cornerstone)
// 1. 小提示: 使用Cornerstone时, 拷贝svn网址, Cornerstone会自动将地址填入界面内.
// 2. 使用Cornerstone, 应该先连接远程仓库(左下角), 然后点击checkout下载代码.
// 注意: checkout选择目录时, 应将底部svn版本选择为1.7. 因为mac默认就是1.7版本. 如果版本过低, xcode会提示升级, 然后Cornerstone重启一次即可

// 3. 忽略文件:
// --1. .xcuserstate 不要提交给服务器. 此文件记录了用户当前展示的文件, 及目录展开结构
// --2. (非项目文件)data后缀的(还包括用户断点) 都可以忽略不提交
// --3. 通过工具, 先delete, 在commit, 再次编辑时就会出现, 最后选择ignore

http://192.168.12.103/svn/wechat/


#pragma mark 使用Xcode集成SVN
// --1. checkout : 三种方式
// 1. xcode欢迎界面, 选择第三个选项, 即可checkout
// 2. 选中xcode, 找偏好设置, 找账户, 左下角添加远程仓库
// 3.  选中xcode, 找顶部的source control菜单, 选择checkout (最简单)

// --2. 常用快捷键
// 1. update : com + opt + x
// 2. commit : com + opt + c

// --3. xcode解决代码冲突
// 只要更新, 一旦冲突, 就会有个界面提示选择. 应该选择下方的四个小按钮, update, 最后commmit就可以了. (没有提示resolved)

// 4. 如果将来写代码, 发现文件改的不像样子, 可以直接丢弃修改

// 5. SB / Xib 发生冲突的解决方案: 需要右键查看源码, 然后自己比对丢失的代码.  团队开发中, 尽量避免界面发生冲突 (如果不小心移动了界面, 那么可以丢弃修改)

#pragma mark SVN目录结构
      // trunk : 开发主目录
      // branch : 分支, 一般用于修复bug或者开发新功能.
      // tags : 备份重大版本(一般可以备份上架AppStore的版本)
