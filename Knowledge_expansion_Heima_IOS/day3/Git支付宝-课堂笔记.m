
#pragma mark - 一. Git

#pragma mark 1. Git介绍 (了解)
分布式的源代码管理工具

#pragma mark 2. Git与SVN区别(了解)
1. 速度
在很多情况下，git的速度远远比SVN快 (可以本地提交, 不用联网)

2. 结构
SVN是集中式管理(代码的版本库, 只在一台服务器存在)
git是分布式管理(代码的版本库, 服务器和每一台客户端都存在)

3. 其他
SVN使用分支比较笨拙(分支和tag是拷贝的形式, 浪费空间,浪费时间)，git可以轻松拥有无限个分支(分支和tag 只是打个标记, 不用拷贝代码)
SVN必须联网才能正常工作(企业中, 离开了公司无法进行SVN的操作)，git支持本地版本控制工作(离开了公司依然可以开发)


#pragma mark 3. Git基本命令的使用(掌握)
一. 如何学习git指令
1. 查看帮助:  git help
2. 查看制定命令 : git help clone (这样就可以查看这个指令的所有操作文档)
3. 搜索关键字 : /clone  (翻页 : F 写一页, B上一页)
4. 如果想退出帮助文档 : 输入 Q

二. 常见命令
# 显示隐藏文件
$ defaults write com.apple.finder AppleShowAllFiles Yes && killall Finder
# 不显示隐藏文件
$ defaults write com.apple.finder AppleShowAllFiles No && killall Finder

单人开发
1. 初始化git本地仓库:git init (.git隐藏文件, 不要轻易乱动)
2. 创建文件 : touch Car.h
3. 查看文件状态 : git status
4. 添加到git版本控制中: git add Car.h
5. 添加多个文件到git版本控制中 : git add .
6. 提交代码 : git commit -m "注释"


红色文件: 文件没有被纳入到git管理中 / 文件被修改了 / 文件发生了冲突
绿色文件: 文件加入到了'暂存区'

三. 配置账号信息 (一般来讲只需要配置一次全局的账号即可)
配置局部信息
1. 用户名 : git config user.name "tangseng" (区分谁开发的)
2. 邮箱信息 : user.email "tangseng.xitian.com" (用于联系开发者)

配置全局信息
1. 用户名: git config --global user.name "wukong"
2. 邮箱信息: git config --global user.email "wukong.huaguoshan.com"

注意:
1. 如果没有配置过账号信息, 那么git会有一个默认的账号信息
2. 如果配置的是全局的信息, 那么在finder --> 前往 --> 个人 --> 隐藏文件.gitconfig . 全局信息将会写入到这个文件内
3. 如果没有配置局部信息, 会用默认的全局信息来提交. 局部如果配置过了, 那么将会使用局部配置的信息

四. 查看日志
1. 查看日志 : git log
2. 版本号 : 40位, 哈希值 . 哈希值是唯一的, 只要服务器看见版本不一样就可以提交到远程服务器
3. 增强版log : 配置带颜色的log别名 提供版本号的前七位
$ git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

五. 起别名
配置局部命令别名 :
1. 查看状态:  git config alias.st "status" -->
    .后面的字符,代表将来要简写的命令. 双引号内的字符, 代表着原来指令的全称
2. 提交内容:  git config alias.ci "commit -m"

配置全局命令别名 :
1. 查看状态:  git config --global alias.st "status" -->
.后面的字符,代表将来要简写的命令. 双引号内的字符, 代表着原来指令的全称
2. 提交内容:  git config --global alias.ci "commit -m"


六. 版本回退 / 版本穿梭

如果文件已经被commit 可以通过git reset --hard HEAD^回退
1. 版本回退: git reset --hard HEAD^ --> 一个^代表一个版本
2. 指定版本 : git reset --hard 8308f01 --> 后面拼接7位的版本号

如果文件没有commit
1. 回退到当前最高版本: git reset --hard HEAD (全部回退）)
2. 检出当前分支的最高版本: git checkout Car.h  (git中 checkout可以做revert的操作, 也就是版本回退)（指定文件的回退）


七. 查看修改参考日志
如果git回到了早期的版本, 那么后面的那些版本将不存在.
如果此时有需求, 需要回退到之前的时候, 那么可以通过 git reflog 来查看之前
每一次的修改日志版本. 此时就可以通过记录的版本进行回退了.

补充:VIM编辑器
想输入内容: i  (同时底部会出现INSERT字样)
退出编辑: esc
退出编辑器: shift + : , 输入wq. 保存退出

#pragma mark 4. Git工作原理(理解)
1. Git本地目录分为 工作区和版本库

2. 版本库包含3个东西:
    暂存区 --> 文件只要发生了改动, 就会在暂存区
    master --> 相当于svn的trunk目录, master是git创建的第一个分支
    HEAD指针 --> 隐藏看不见的, 默认指向master分支

3. Git的add和commit原理
add : 添加到暂存区
commit : 添加到本地master分支
push : 将master分支代码提交给服务器

#pragma mark 5. Git多人开发(掌握)
服务器地址: Git的服务器 , 文件夹, U盘, 云盘

一. 初始化服务器
1. 初始化服务器 : git init --bare
2. 克隆代码(下载) : git clone /Users/dream/Desktop/Git/service

二. 设置忽略文件
1. 先去Github, 搜索.gitignore, 然后找到OC的忽略文件
2. 拷贝所有内容, 来到终端
3. echo -e "(com + V 输入粘贴内容)" > .gitignore
4. 保证.gitignore 跟.git在同一目录下 (.git这个目录才是git管理的目论)
5. 将.gitignore推送给远程服务器 add / commit  / push (一定要在创建项目之前)
6. 推送本地分支代码给服务器: git push

三. 使用xcode创建项目
1. 如果目录以及包含了.git的管理, 那么xcode创建项目时, 底部的git无法勾选
2. xcode帮我们做了add, 所以, 直接commit 然后push即可

四. 新人加入开发
1. 克隆服务器代码: git clone /Users/dream/Desktop/Git/service
2. 一定记得, 在commit之前配置账号信息 (这里只是为了演示多人开发, 所以会配置局部账号. 开发中不需要这样做)
3. 如果想要拿到分支最新代码, 应该执行: git pull

五. 代码冲突
1. 两个人都要commit过代码,一个已经push, 令一个pull, 此时可能就会发生冲突
2. 如果发生了冲突, 按照svn的方式解决: 选中?, 然后点击底部的四个小按钮, 最后点击pull
3. pull之后, 还需要进行commit 和 push. 其他人pull才会代码同步

六. 界面冲突
1. 如果发生了冲突, 一般保留所有代码(选中?, 然后点击底部的四个小按钮)
2. 需要打开SB/Xib查看, 如果发生了冲突, 会提示错误出现在哪里行中, 然后自行比较缺失的代码, 进行填补
3. 填补完成, 再次打开就OK. 如果还有错误, 继续2,3步.


#pragma mark 6. Xcode集成Git(掌握)
1. xcode, commit会做两件事: add / commit
2. 如果commit时, 勾选了左下角的push to remote , 勾选了此按钮, 那么提交时做三件事 : add  / commit /push
3. 如果是使用xcode在参加项目时, 就勾选了git控制, 默认会帮我们添加好忽略文件


#pragma mark 7. Git远程服务器-OSChina(掌握)
git.oschina.net --> github.com 翻版
Github / oschina 上的ReadMe文件, 使用的语法是Markdown

1. 注册账号, 然后参加项目, 填写项目名/忽略文件/许可协议/RemdeMe文件
2. 直接拷贝https://的网址, 本地进行clonge
3. 在此项目文件夹内, 参加项目, 并提交 .push时需要账号和密码
(账号: 在oschina上的用户名 - 密码, 是oschine登陆密码)
4. 如果将来多人参与开发, 那么可以点击右上角的管理, 进行团队开发人员的权限控制


#pragma mark 8. Git分支管理(理解)
一. 分支的使用
1. xcode --> source control --> master --> new branch --> 一旦完成操作, 会自动切换到分支下.
2. 主分支和分支可以随时切换, 分支开发的功能, 不会提交到主分支上
3. 如果要合并代码, 比如选中了分支 --> source control --> Merge info barnch .
4. merge时, xcode会提示分支发生哪些变化, 可以用下面小按钮来选择是否要是否用分支的代码. (如果要使用, 默认不用改).
5. 如果分支选择了Merge info barnch, 合并成功后, 会自动切换到master分支下

分支使用举例: 比如公司有个模块, 技术实现可以有3种, 那么我们可以在分支上实验, 如果实验成功再合并, 如果实现不成功, 分支可以直接删除.

二. tag 打标记
使用tag，就能够将项目快速切换到某一个中间状态，例如产品开发线上的某一个稳定版本

使用git checkout tag即可切换到指定tag，例如：git checkout v0.1.0

1. 查看当前标签: git tag
2. 在本地代码库给项目打上一个标签: git tag -a v1.0 -m 'Version 1.0'
3. 将标签添推送到远程代码库中: git push origin v1.0
4. 签出v1.0标签: git checkout v1.0
5. 从签出状态创建v1.0bugfix分支: git checkout -b bugfix1.0

删除tag
git tag -d 1.0.1.RC

#pragma mark - 二. 支付宝

#pragma mark 1. 支付宝流程介绍 (了解)

#pragma mark 2. 支付宝集成(掌握)
1. 网址: http://open.alipay.com
2. 参照文档集成即可
