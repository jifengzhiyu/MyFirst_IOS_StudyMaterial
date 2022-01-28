 // 购买苹果开发者账号
// 1.apple id
// 2.https://developer.apple.com
// 3.member center
// 4.add-ons
// 5.enroll now
// 6.谢谢您

// 开发者账号的类型
// 1.个人-99刀!
// 能上架 给钱就能用
// 2.企业-99刀!
// 能上架 团队开发 需要"邓白氏"认证
// 3.商业-299刀!
// 不能上架 但是不向apple store提交应用

// 真机调试
// 1.电脑
// 2.手机
// UDID
// 3.程序
// id:cn.itcast.caipiao

// http://www.itcast.cn/news/20150907/14445174114.shtml Xcode 7 真机调试

// 打电话(tel) 发短信(sms)
//UIApplication * app = [UIApplication sharedApplication];
//NSURL * url = [NSURL URLWithString:@"tel://10010"];
//[app openURL:url];

// 跳转苹果商店
//UIApplication *app = [UIApplication sharedApplication];
//NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/id414478124?mt=8&ls=1"];
//[app openURL:url];

// 程序之间的跳转 (openUrl  如果能够打开,直接打开 如果不能打开,返回no)
//// 获取app对象
//UIApplication *app = [UIApplication sharedApplication];
//// 应用程序的url
//NSURL * appUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@",p.customUrl,p.ids]];
//// 应用商店的url
//NSURL * storeUrl = [NSURL URLWithString:p.url];
//// --------------- iOS9 ---------------
//if(![app openURL:appUrl]) {
//    // 跳转到苹果商店
//    [app openURL:storeUrl];
//}

// 读取硬件信息
// http://stackoverflow.com/questions/8223348/ios-get-cpu-usage-from-application

// 上传 发布

// 打包