# 第三方框架

## 项目中使用到以下第三方框架

* `AFNetworking`
* `SDWebImage`
* `SVProgressHUD`
* `SnapKit`
* `Alamofire`

## Pod 安装

* git 备份
* 打开终端
* `$ cd` 进入项目目录
* 输入以下终端命令建立或编辑 `Podfile`

```bash
$ pod init
```

* 将 Podfile 拖入 Xcode 输入以下内容

```
use_frameworks!
platform :ios, '8.0'
pod 'AFNetworking'
pod 'SDWebImage'
pod 'SVProgressHUD'
pod 'SnapKit'
```

* 输入以下命令安装第三方框架

```bash
$ pod install --no-repo-update
```

* 如果第三方框架不能正常工作或者升级，可以输入以下命令更新

```bash
$ pod update --no-repo-update
```

> 在 Swift 项目中，cocoapod 仅支持以 Framework 方式添加框架，因此需要在 Podfile 中添加 `use_frameworks!`


