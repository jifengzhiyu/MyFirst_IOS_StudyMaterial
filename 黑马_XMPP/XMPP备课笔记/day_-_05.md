# 融云
iOS SDK 2.0 开发指南
在您阅读此文档之前，我们假定您已经具备了基础的 iOS 应用开发经验，并能够理解相关基础概念。
注册开发者帐号
请前往 融云官方网站 注册开发者帐号。注册时，您需要提供真实的邮箱和手机号，以方便我们向您发送重要通知并在紧急时刻能够联系到您。如果您没有提供正确可用的邮箱和手机号，我们随时可能关闭您的应用。
下载 SDK
您可以到 融云官方网站 下载融云 SDK。
SDK 下载包中分为如下两部分：
•	融云 IM 界面组件 - RongCloud IMKit
•	融云 IM 通讯能力库 - RongCloud IMLib
好的，下载应该已经开始了，您可以在下载过程中继续向下阅读。
首先，让我们先创建您的第一个应用吧！
注：由于 iOS 开发编译原理的特殊性，下载的 SDK 包中的 .a 文件尺寸较大，但并不等于会让最终的 ipa 文件尺寸有相应的增加。实际最终会增加您的 App 尺寸大概 2MB 左右。
SDK 解压后会得到 zh-Hans.lproj 和 en.lproj 两个语言包，将语言包拖入到项目中，即可支持国际化。
创建应用
您要进行应用开发之前，需要先在融云开发者平台创建应用。如果您已经注册了融云开发者帐号，请前往 融云开发者平台 创建应用；如果您还没有注册融云开发者帐号，请前往 融云官方网站 首先注册开发者帐号，注册后创建应用。
您创建完应用后，最需要了解的就是 App Key / Secret，它们是融云 SDK 连接服务器所必须的标识，每一个 App 对应一套 App Key / Secret。针对开发者的生产环境和开发环境，我们提供两套 App Key / Secret，您在应用最终上线前，使用开发环境即可，两套环境的功能完全一致。

App Key / Secret 位置
开发环境 App Key / Secret 是专门为您提供的仅供开发使用的，开发环境将和生产环境的数据隔离，避免开发环境数据和线上生产环境数据互相冲突。在“开发环境”分类下，您可以找到开发 App Key / Secret。您在申请上线前可以一直使用开发环境的 App Key / Secret 开发。

生产环境的 App Key / Secret 默认先不提供，等您提交上线后，我们会提供生产环境的 App Key / Secret。

Token 有效期默认为永久有效，也可以设置有效期，这有助于提高您 App 的安全性，具体请参考 Server 开发文档。
开发准备
以下文档将向大家介绍 IMKit 界面组件的开发方法。如果您想了解如何使用 IMLib，我们提供了 API 文档。

我们的 SDK 最低支持到 iOS 6.0，请您在构建项目时注意。随着苹果官方的支持情况变化，我们很快会转而支持 iOS 7.0 和 8.0，6.0 的兼容性我们不再主动维护，但是如果您发现兼容性问题，可以发工单联系我们修复。
1、创建项目
创建 Demo 项目时，为了方便演示，请选择创建一个 Empty Application 。

创建 Empty Application
2.1、通过 CocoaPods 安装
CocoaPods 是流行的 Cocoa 项目依赖管理工具，我们推荐您优先使用 CocoaPods 来安装 SDK，这样可以极大的简化安装过程。下面介绍具体步骤：
在您的项目根目录创建一个 Podfile 文件，添加如下内容来引用 IMKit 界面组件库：
pod 'RongCloudIMKit'
如果您需要引用 IMLib 通讯能力库，可以添加：
pod 'RongCloudIMLib'
请不要同时引用 IMKit 和 IMLib，因为 IMKit 中已经包含了 IMLib。重复引用会导致引用冲突，无法正常编译。
然后，执行命令 pod install 安装 融云 SDK。
注意：以后打开项目时，需要使用 CocoaPods 生成的 .xcworkspace 打开，而不是之前的 .xcodeproj。
您可以参考 《CocoaPods 安装和使用教程》 这篇文章来学习如何使用 CocoaPods。
此处特别感谢求攻略的 Zhuohui Yu 帮助创建和维护融云的 CocoaPods 项目。
2.2、手动安装融云 SDK
引用文件
将官网下载的 Rong_Cloud_iOS_SDK_vx_x_x.zip 包解压到任意目录。在您的项目中加入 RongIMLib.framework，RongIMKit.framework，libopencore-amrnb.a， 在你项目的 Resource 目录中加入 RongCloud.bundle。
添加依赖库
工程中需要依赖的库如下（根据使用的功能不同，某些库并不是所有情况下都需要）：
•	AssetsLibrary.framework
•	AudioToolbox.framework
•	AVFoundation.framework
•	CFNetwork.framework
•	CoreAudio.framework
•	CoreLocation.framework
•	CoreMedia.framework
•	CoreTelephony.framework
•	CoreVideo.framework
•	CoreGraphics.framework
•	ImageIO.framework
•	libc++.dylib
•	libc++abi.dylib
•	libsqlite3.dylib
•	libstdc++.dylib
•	libxml2.dylib
•	libz.dylib
•	MapKit.framework
•	OpenGLES.framework
•	QuartzCore.framework
•	SystemConfiguration.framework
•	UIKit.framework
如果您使用的是 Xcode 7 开发工具，需要将 .dylib 替换成 .tbd 。 在项目构建过程有更多疑问，我们推荐您参考我们的开源项目，您的问题基本可以参考解决： https://github.com/rongcloud/demo-app-ios-v2
如果您从 1.0 至 1.4 版本升级到 2.0 以上的版本，请参考 升级说明文档
3、获取 Token
Token 也叫用户令牌，是 SDK 端用来连接融云服务器的凭证，每个用户连接服务器都需要一个 Token。每次初始化连接服务器时，都需要向服务器提交 Token。
获取用户 Token 并连接的流程如下： 1， 首先，您的 App 查询您的应用程序服务器， 2， 然后，您的应用程序服务器再访问融云服务器获取，最后返回给 App， 3， App 用返回的 Token 直接连接融云服务器登录。 详细描述请参考 Server 开发指南 中的身份认证服务小节。
为了方便您进行测试开发，我们还提供了 API 调试工具，以便您不用部署服务器端程序，即可直接获得测试开发所需的 Token。请访问 融云开发者平台，打开您想测试的应用，在左侧菜单中选择“API 调试”即可。融云拥有业内最丰富功能的开发者后台服务，我们建议所有开发者先熟悉后台的功能。

API 调试工具
您可以用这个 API 调试工具生成一个 Token，这里我们为您举一个例子，假设您生成 Token 时使用的参数如下：
用户 Id：
userId = "1" // 用户在融云系统中唯一的身份 Id，可为任意数字或字符串，但必须保证全局唯一。
用户名称：
name = "韩梅梅" // 用户的显示名称，用来在 Push 推送时，或者客户端没有提供用户信息时，显示用户的名称。
用户头像图片：
portraitUri = "http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png"
这里为了测试，您可以随意提供一个地址，如果此图片不存在，IMKit 会显示默认的头像。
通过API调试窗口，你即可以看到返回的 Token，这个 Token 就是您 App 中 userId = "1" 的这位用户连接融云，并与其他用户通讯的唯一凭证。
请务必清楚的了解 Token 的概念，对您使用融云服务开发非常重要。
快速集成
快速集成是融云的产品的核心特色之一，在您耐心的理解了相关概念和准备好工程的前提下，您可以通过以下四个步骤就完成全部功能的集成。可以启动会话列表和会话界面，并能发送各种文本，语音，图片，位置消息。
以下将介绍将 IMKit 快速集成进您的 App 并实现基本功能，为了您更方便集成，我们同时准备了 Quick Start Demo，用最轻量的代码实现了快速集成，请参考: https://github.com/rongcloud/demo-app-ios-quick-start
该 Demo 只是为了展示融云 IMKit 集成的快速和简单，代码非常简短，目的是方便您阅读代码，并不能使用和体验融云产品功能。
1、初始化 SDK
请使用您之前从融云开发者平台注册得到的 App Key，传入 initWithAppKey:deviceToken: 方法，初始化 SDK。
在整个应用程序全局，只需要调用一次 initWithAppKey:deviceToken: 方法。
#import <RongIMKit/RongIMKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  //初始化融云SDK。
  [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY ];
}

@end
以上代码中的 App Key 值 RONGCLOUD_IM_APPKEY 仅为示例，请注意必须替换为您自己的 App Key 值。
您在使用 IM 时需要收到 APNS 的远程通知（Remote Notification），因此您需要 setDeviceToken 来把 DeviceToken 传给融云 SDK，
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

      /**
       * 推送处理1
       */
      if ([application
              respondsToSelector:@selector(registerUserNotificationSettings:)]) {
          UIUserNotificationSettings *settings = [UIUserNotificationSettings
              settingsForTypes:(UIUserNotificationTypeBadge |
                                UIUserNotificationTypeSound |
                                UIUserNotificationTypeAlert)
                    categories:nil];
          [application registerUserNotificationSettings:settings];
        } else {
          UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
                                             UIRemoteNotificationTypeAlert |
                                             UIRemoteNotificationTypeSound;
          [application registerForRemoteNotificationTypes:myTypes];
        }

}

/**
 * 推送处理2
 */
//注册用户通知设置
- (void)application:(UIApplication *)application
    didRegisterUserNotificationSettings:
        (UIUserNotificationSettings *)notificationSettings {
  // register to receive notifications
  [application registerForRemoteNotifications];
}

/**
 * 推送处理3
 */
- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  NSString *token =
      [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                             withString:@""]
          stringByReplacingOccurrencesOfString:@">"
                                    withString:@""]
          stringByReplacingOccurrencesOfString:@" "
                                    withString:@""];

  [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}
请注意您必须通过 setDeviceToken 传入设备信息，才能收到苹果的 APNS 远程通知，否则在您的应用退出之后，您无法收到消息的远程通知。请参考我们的开源 Demo 项目，其中对此做了详尽的注释。
2、连接服务器
将您在请求身份认证服务器时获取的 Token 传入 connectWithToken 方法，开始连接服务器。
在整个应用程序全局，只需要调用一次 connectWithToken 方法，SDK 会负责自动重连。您也可以跟自己的需要选择主动重连。
    // 快速集成第二步，连接融云服务器
    [[RCIM sharedRCIM] connectWithToken:RONGCLOUD_IM_USER_TOKEN success:^(NSString *userId) {
        // Connect 成功
    }
    error:^(RCConnectErrorCode status) {
        // Connect 失败
    }
    tokenIncorrect:^() {
        // Token 失效的状态处理
    }];
以上代码中的 Token 值 RONGCLOUD_IM_USER_TOKEN 为示例，请注意替换为您自己的 Token 值。
以上示例方法不是唯一的解决方案，你可以选择合适的时机对 SDK 进行连接操作，且您可以主动选择重新连接。
3、启动会话列表界面
融云 IMKit 已经实现了完整的会话界面，使用标准的MVC框架，所以您只需要创建自己的会话视图控制器（View Controller），继承融云的视图控制器，既可以快速的启动和控制聊天界面。
以下为一个例子，注意 ChatListViewController 是您 App 自己实现的 View Controller，继承于 RCConversationListViewController。
@interface ChatListViewController : RCConversationListViewController
//快速集成第三步，在您需要的时机初始化会话列表，并跳转会话列表
RCConversationListViewController * chat=[RCConversationListViewController alloc]initWithDisplayConversationTypes:<#(NSArray *)#> collectionConversationType:<#(NSArray *)#>

[self.navigationController pushViewController:chatListViewController animated:YES];
然后您 copy 以下一段代码到您的会话控制器内，就可以从您的会话列表跳转到会话界面了。
@implementation ChatListViewController

//重载函数，onSelectedTableRow 是选择会话列表之后的事件，该接口开放是为了便于您自定义跳转事件。在快速集成过程中，您只需要复制这段代码。
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.userName =model.conversationTitle;
    conversationVC.title = model.conversationTitle;
    [self.navigationController pushViewController:conversationVC animated:YES];
}
4、启动单聊会话界面
融云 IMKit 的会话界面已经高度集成，您只需要启动会话界面。发送消息的过程将由融云替您完成。完成上一步后您已经可以跳转会话界面，但需要将会话类型赋值给您的 View Controller，这样就可以直接调起会话界面。
// 快速集成第四步，发起单聊会话。
-(void)rightBarButtonItemPressed:(id)sender
{
  // 您需要根据自己的 App 选择场景触发聊天。这里的例子是一个 Button 点击事件。
  RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
  conversationVC.conversationType =ConversationType_PRIVATE; //会话类型，这里设置为 PRIVATE 即发起单聊会话。
  conversationVC.targetId = @"id_xxxx"; // 接收者的 targetId，这里为举例。
  conversationVC.userName = @"name_xxx"; // 接受者的 username，这里为举例。
  conversationVC.title = @"name_xxx"; // 会话的 title。

  // 把单聊视图控制器添加到导航栈。
  [self.navigationController pushViewController:conversationVC animated:YES];

}
融云 IMKit 高度集成了各种场景，当您完成上述集成步骤后，您就可以直接通过输入框和下拉菜单发送文本、图片、语音、位置消息了。已经不需要再去一步步调试如何发送图片语音等消息。这是融云的主要产品特色，即真正的快速集成。 至此，快速集成已经完成，您接下来将会关心更多的功能，请继续阅读相关文档。
功能进阶
启动客服聊天界面
原理同上，您只需要创建自己的视图控制器，您的 App 就可以直接调起客服聊天界面。
    RCConversationViewController *chatService = [[RCConversationViewController alloc] init];
    chatService.targetName = @"客服";
    chatService.targetId = SERVICE_ID;
    chatService.conversationType = ConversationType_CUSTOMERSERVICE;

    // 把客服聊天视图控制器添加到导航栈。
    [self.navigationController pushViewController:chatViewController animated:YES];
其中，SERVICE_ID 的值，可以在 融云开发者平台 的客服模块中找到。位置为：xx应用 / 功能模块 / 客服模块 / 开发环境 / 查看详情。查看 customerServiceId 之前，请您先开启客服功能。

customerServiceId 值的位置
群组功能
群组业务的描述，请参见快速入门中的说明。
因群组信息与群成员信息是由 App 维护管理并提供的，所以，处理群组的业务逻辑就是处理数据同步的逻辑。主要逻辑如下：
融云当前群组的架构设计决定，您不需要调用融云服务器去“创建”群组，也就是告诉融云服务器哪些群组有哪些用户。您只需要同步当前用户所属的群组信息给融云服务器，即相当于“订阅”或者“取消订阅”了所属群组的消息。融云会根据用户同步的群组数据，计算群组的成员信息并群发消息。
同步群组信息 syncGroup
开发文档链接：syncGroups:completion:error:
用于同步当前登录用户已经加入的群组信息，需要提交当前用户所有加入的群组信息（群组信息包含 groupId：群唯一标识，groupName：群名称）。 融云服务器会根据你提交的群信息与之前提交的群信息进行比对，根据差异结果进行加入或退出操作。提交此信息后该用户可以收到这些群的消息，且可以向这些群内发送数据。
为了确保群组关系的正确同步，最好在每次完成初始化并成功连接融云服务后调用此方法。
加入群 joinGroup
开发文档链接：joinGroup:groupName:completion:error:
此方法可以在 App 运行过程中实现将当前登录用户加入群组。在方法响应成功后，该用户可以收到所加入的群组的消息，且可以向该群组发送数据。请在您的 App 中实现当前用户加入群组时，调用此方法。
退出群 quitGroup
开发文档链接：quitGroup:completion:error:
此方法可以在 App 运行过程中实现当前登录用户退出已加入的群组。在方法响应成功后，该用户将不会再收到该群组的消息，且不再可以向该群组发送数据。请在您的 App 中实现当前用户退出群组时，调用此方法。
聊天室功能
聊天室业务的描述，请参见快速入门中的说明。
聊天室与群组最大的不同在于，聊天室的消息没有 Push 通知，也没有成员的概念。想参与聊天室聊天，接收聊天室消息，加入聊天室即可；不参与聊天室聊天，不接收消息，退出聊天室即可。IMKit 组件中已经内置了加入和退出讨论组的接口调用，您直接启动即可：
    // 启动聊天室，与启动单聊等类似
    RCConversationViewController *temp = [[RCConversationViewController alloc]init];
    temp.targetId = @"19527";
    temp.conversationType = ConversationType_CHATROOM;// 传入聊天室类型
    temp.userName = @"用户名称";
    temp.title = @"聊天室标题";
    [self.navigationController pushViewController:temp animated:YES];
因聊天室没有成员关系，需要在每次显示聊天室聊天界面之前，执行加入聊天室的操作，并在退出聊天室聊天界面之后执行退出聊天室的操作。否则，您的 App 将消耗不必要的流量（不退出聊天室将会持续接收来自该聊天室的消息），请在使用 IMLib 开发时注意。
实现了以上功能以后，您就可以实现在 App 中的简单一对一聊天服务了，但是您还看不到用户昵称、头像等信息。所以，为了实现上述功能，您还需要在 App 真正发布前继续完善一些代码。
显示用户昵称和头像
设计原理说明：
融云认为，每一个设计良好且功能健全的 App 都应该能够在本地获取、缓存并在合适的时机更新 App 中的用户信息。所以，融云不维护和管理用户的基本信息（用户 Id、昵称、头像）的获取、缓存、变更和同步。此外，App 提供用户信息也避免了由于缓存导致的用户信息更新不及时，App 中不同界面上的用户信息不统一（比如：一部分 App 从 App 服务器上获取并显示，一部分由融云服务器获取并显示），能够获得最佳的用户体验。
融云通过让开发者在 IMKit 中设置用户信息提供者的方式来实现在聊天界面和会话列表页中实现通过 App 的数据源来显示用户昵称和头像。
设置用户信息提供者即通过调用 setUserInfoDataSource: 方法设置 RCIMUserInfoDataSource。用户信息提供者采用 Provider 模式，即您提供给融云的 IMKit 一个 RCIMUserInfoDataSource，当融云的 IMKit 需要使用用户信息的时候，调用您传入的 getUserInfoWithUserId: 方法，向您获取用户信息。所以您在 getUserInfoWithUserId: 方法中，需要根据传入的 userId 参数，向我们返回对应的用户信息。
代码请参见下节，我们将一起展示。
虽然您可以通过调用 [https://api.cn.rong.io/user/getToken.[format]](server.html#_身份认证服务接口说明) 换取 Token 的方式将用户昵称和头像提供给我们，并且可以通过重新换取 Token 的方式刷新用户资料，但是我们非常不推荐这种方式。这种方式会造成客户端的性能问题和用户信息更新不及时。

我们强烈推荐您实现本地的 RCIMUserInfoDataSource，并在客户端对用户信息进行缓存。
显示群组信息
在群组业务中，融云只是同步群组关系数据，并不保存群组的具体信息。所以，当界面组件创建会话需要显示群组信息时，需要向 App 获取。App 需要设置一个群组信息提供者给 IMKit，以便 IMKit 读取好友关系。群组信息提供者 RCIMGroupInfoDataSource 的设计模式与用户信息提供者 RCIMUserInfoDataSource 相同，可以参考用户信息提供者 RCIMUserInfoDataSource 的说明。
只有您使用融云 IMKit 提供的群组功能时，才需要设置群组信息提供者。如果您没有使用群组功能，则不需要设置群组信息提供者。
代码分成两部分，分别是 AppDelegate.h 文件和 AppDelegate.m 文件。
AppDelegate.h 文件如下：
#import <UIKit/UIKit.h>
// 引用 IMKit 头文件。
#import "RCIM.h"

// 添加获取用户信息和群组信息的 Protocol。
@interface AppDelegate : UIResponder <UIApplicationDelegate, RCIMUserInfoDataSource, RCIMGroupInfoDataSource>

@property (strong, nonatomic) UIWindow *window;

@end
AppDelegate.m 文件如下：
#import "AppDelegate.h"
// 引用 IMKit 头文件。
#import "RCIM.h"
// 引用 ViewController 头文件。
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    // 初始化 SDK，传入 App Key，deviceToken 暂时为空，等待获取权限。
    [RCIM initWithAppKey:@"e7x8xycsx6flq" deviceToken:nil];

    // 设置用户信息提供者。
    [RCIM setUserInfoDataSource:self];
    // 设置群组信息提供者。
    [RCIM setGroupInfoDataSource:self];

#ifdef __IPHONE_8_0
    // 在 iOS 8 下注册苹果推送，申请推送权限。
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge
                                                                                         |UIUserNotificationTypeSound
                                                                                         |UIUserNotificationTypeAlert) categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#else
    // 注册苹果推送，申请推送权限。
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
#endif

    // 初始化 ViewController。
    ViewController *viewController = [[ViewController alloc]initWithNibName:nil bundle:nil];

    // 初始化 UINavigationController。
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];

    // 设置背景颜色为黑色。
    [nav.navigationBar setBackgroundColor:[UIColor blackColor]];

    // 初始化 rootViewController。
    self.window.rootViewController = nav;

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    // Register to receive notifications.
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    // Handle the actions.
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif

// 获取苹果推送权限成功。
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 设置 deviceToken。
    [[RCIM sharedRCIM] setDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {

}

// 获取用户信息的方法。
-(void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    // 此处最终代码逻辑实现需要您从本地缓存或服务器端获取用户信息。

    if ([@"1" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"1";
        user.name = @"韩梅梅";
        user.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";

        return completion(user);
    }

    if ([@"2" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"2";
        user.name = @"李雷";
        user.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";

        return completion(user);
    }

    return completion(nil);
}

// 获取群组信息的方法。
-(void)getGroupInfoWithGroupId:(NSString*)groupId completion:(void (^)(RCGroup *group))completion
{
    // 此处最终代码逻辑实现需要您从本地缓存或服务器端获取群组信息。

    if ([@"1" isEqual:groupId]) {
        RCGroup *group = [[RCGroup alloc]init];
        group.groupId = @"1";
        group.groupName = @"同城交友";
        //group.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";

        return completion(group);
    }

    if ([@"2" isEqual:groupId]) {
        RCGroup *group = [[RCGroup alloc]init];
        group.groupId = @"2";
        group.groupName = @"跳蚤市场";
        //group.portraitUri = @"http://rongcloud-web.qiniudn.com/docs_demo_rongcloud_logo.png";

        return completion(group);
    }

    return completion(nil);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
公众号功能
为丰富您的 App 业务能力，快速满足用户需求。融云为 App 推出公众号服务功能。开发者在 融云开发者平台 的公众服务模块中，通过添加公众服务或应用服务中的公众号到自已的应用中，来丰富 App 业务能力，快速满足用户需求。
公众服务功能：
搜索公众号
通过 searchPublicService 或 searchPublicServiceByType 方法搜索已经添加的公众号列表，可以按关键字模糊匹配方式进行搜索。
/**
 *  搜索所有公众账号
 *
 *  @param searchKey          关键字
 *  @param searchType         匹配模式：精确匹配或者模糊匹配
 *  @param success            查询成功：返回RCPublicServiceProfile的数组
 *  @param error              查询失败：返回错误码
 */

- (void)searchPublicService:(RCSearchType)searchType
                  searchKey:(NSString *)searchKey
                    success:(void (^)(NSArray *accounts))successBlock
                      error:(void (^)(RCErrorCode status))errorBlock;

/**
 *  按类型搜索公众账号
 *
 *  @param publicServiceType  搜索范围：全部搜索，公众号开发者，第三方平台
 *  @param searchKey          关键字
 *  @param searchType         匹配模式：精确匹配或者模糊匹配
 *  @param success            查询成功：返回RCPublicServiceProfile的数组
 *  @param error              查询失败：返回错误码
 */

- (void)searchPublicServiceByType:(RCPublicServiceType)publicServiceType
                       searchType:(RCSearchType)searchType
                        searchKey:(NSString *)searchKey
                          success:(void (^)(NSArray *accounts))successBlock
                            error:(void (^)(RCErrorCode status))errorBlock;
获取某公众号信息
在需要显示某一个公众号信息时，可通过 getPublicServiceProfile 方法获取某一公众号的基本信息。
/**
 *  获取公众号信息
 *
 *  @param publicServiceType  公众号开发者，第三方平台
 *  @param publicServiceId    公众号 Id
 *
 *  @return RCPublicServiceProfile
 */
- (RCPublicServiceProfile *)getPublicServiceProfile:(RCPublicServiceType)publicServiceType
                                 publicServiceId:(NSString *)publicServiceId;
订阅/取消公众号
用户在应用中搜索到公众号后，可通过 subscribePublicService 和 unsubscribePublicService 接口实现对公众号的订阅或取消订阅功能。
订阅公众号：
/**
 *  订阅公众账号服务
 *
 *  @param publicServiceType  公众号开发者，第三方平台
 *  @param publicServiceId    公众号 Id
 *  @param success            订阅成功
 *  @param error              订阅失败
 */
- (void)subscribePublicService:(RCPublicServiceType)publicServiceType
               publicServiceId:(NSString *)publicServiceId
                       success:(void (^)())successBlock
                         error:(void (^)(RCErrorCode status))errorBlock;
取消订阅公众号：
/**
 *  取消订阅公众账号服务
 *
 *  @param publicServiceType  公众号开发者，第三方平台
 *  @param publicServiceId    公众号 Id
 *  @param success            取消订阅成功
 *  @param error              取消订阅失败
 */
- (void)unsubscribePublicService:(RCPublicServiceType)publicServiceType
                 publicServiceId:(NSString *)publicServiceId
                         success:(void (^)())successBlock
                           error:(void (^)(RCErrorCode status))errorBlock;
获取己关注公众服务列表
在应用中需要展示已关注公众服务列表时，可通过 getPublicServiceList 方法获取己关注公众服务列表信息。
/**
 *  查询已关注的公众号
 *
 *  @return 公众服务列表
 */
- (NSArray *)getPublicServiceList;
IMKit 公众号功能
IMKit 组件中已经内置了获取已关注公众号列表及搜索、打开公众服务会话界面、订阅和取消订阅公众号的接口调用，您直接启动即可：
// 启动已关注的公众号列表功能
RCPublicServiceListViewController *publicServiceVC = [[RCPublicServiceListViewController alloc] init];
[self.navigationController pushViewController:publicServiceVC  animated:YES];

// 启动搜索公众号功能
RCPublicServiceSearchViewController *searchFirendVC = [[RCPublicServiceSearchViewController alloc] init];
[self.navigationController pushViewController:searchFirendVC  animated:YES];
启动公众服务会话界面
如开发者想自已实现启动公众服务会话界面，需要在初始化公众服务会话时，正确初始化基类，比如服务号 Id 、会众服务类型、服务号名称和会话标题，例如：
RCPublicServiceChatViewController *conversationVC = [[RCPublicServiceChatViewController alloc] init];
conversationVC.conversationType = conversationType;
conversationVC.targetId = targetId;
conversationVC.userName = conversationTitle;
conversationVC.title = conversationTitle;
[self.navigationController pushViewController:conversationVC animated:YES];
App 接收的消息推送格式
服务端对客户端推送消息后，客户端将会收到 json 格式的推送消息，如下：
{
　　"aps" :
      { "alert" :
         {
           "action-loc-key" : "显示" ,
           "body" : "This is the alert text"
         },
         "badge" : 1,
         "sound" : "default"
      },
   "rc":{"cType":"PR","fId":"xxx","oName":"xxx","tId":"xxxx"},
   "appData":"xxxx"
}
rc 数据说明：
名称	类型	说明
cType	String	会话类型，PR 单聊、 DS 讨论组、 GRP 群组、 CS 客服、SYS 系统会话、 MC 应用公众服务、 MP 公众服务。
fId	String	发送用户 Id。
oName	String	消息类型，参考融云消息类型表.消息标志；可自定义消息类型。。
tId	String	接收用户 Id。
appData	String	Push 通知附加信息。
在 RongIMKit 中使用 RongIMLib 方法
在 RongIMKit 是对 RongIMLib 的 UI 封装，在 RongIMKit 中可以直接使用 RongIMLib 中的所有方法，代码如下：
NSArray *messageArray = [[RCIMClient sharedRCIMClient] getLatestMessages:self.conversationType targetId:self.currentTarget count:10];
更多的融云 SDK UI 组件请参考融云开源的 Demo 例子。
https://github.com/rongcloud/demo-app-ios
UI 自定义
会话列表自定义
在应用的会话列表中经常会出很多会话的情况，为使会话列表更加清晰，满足开发者对会话列表的定制化需求，融会 SDK 2.0 在会话列表中新增了按照会话类型设置会话列表显示机制：铺开显示、聚合显示、不显示。
现在支持在会话列表中聚合显示的会话类型包括：群组、讨论组、单聊可分别对某一会话类型设置是否聚合显示，默认状态下为铺开显示。
点击聚合后的某一会话类型，显示该会话类型的所有会话列表。
RCConversationListViewController 会话列表基类，可通过继承该基类实现自定议功能。
会话列表自定义请参见： RCConversationListViewController
RCConversationListViewController
@Description: 会话列表基类，子类可从该基类继承

@property
/**
 * 存储当前的会话数据，用于在会话列表展示，子类可以调用该属性来加载呈现
 */
@property (nonatomic,strong) NSMutableArray *conversationListDataSource;

/**
 * 用于更改设置当前会话列表tableView
 */
@property (nonatomic,strong) UITableView *conversationListTableView;

/**
 *  用于更改设置网络指示View
 */
@property (nonatomic, strong) RCNetworkIndicatorView *networkIndicatorView;

/**
 *  设置需要显示的会话列表类型， 存储数据为NSNumber类型
 */
@property (nonatomic ,strong) NSArray *displayConversationTypeArray;

/**
 *  设置要显示的聚合会话类型，存储数据为NSNumber类型
 */
@property (nonatomic ,strong) NSArray *collectionConversationTypeArray;

@method - 子类需要调用的方法
/**
 * 初始化当前类，并设置需要显示的会话类型和聚合会话类型
 */
-(id)initWithDisplayConversationTypes:(NSArray*)conversationTypeArray1 collectionConversationType: (NSArray*)conversationTypeArray2;

/**
 *  设置需要显示的会话类型
 *
 *  @param conversationTypeArray 会话类型，NSNumber类型。
 */
-(void)setDisplayConversationTypes:(NSArray*)conversationTypeArray;

/**
 *  设置需要聚合显示的会话类型
 *
 *  @param conversationTypeArray 会话类型，NSNumber类型。
 */
-(void)setCollectionConversationType: (NSArray*)conversationTypeArray;


/**
 *  设置头像样式,请在viewDidLoad之前调用
 *
 *  @param avatarStyle avatarStyle
 */
-(void)setConversationAvatarStyle:(RCUserAvatarStyle)avatarStyle;

/**
 *  设置头像大小,请在viewDidLoad之前调用
 *
 *  @param size size
 */
-(void)setConversationPortraitSize:(CGSize)size;

/**
 *  刷新会话列表
 */
-(void)refreshConversationTableViewIfNeeded;

@method - 子类需要重写的方法
#pragma mark override
/**
 *  表格选中事件，子类从重写这个方法来监听点击事件并做相应的业务处理
 *
 *  @param conversationModelType 数据模型类型
 *  @param model                 数据模型
 *  @param indexPath             索引
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel*)model atIndexPath:(NSIndexPath *)indexPath;

#pragma mark override
/**
 *  将要加载table数据，子类通过重写该方法添加自定义的数据源，然后通过属性  conversationListDataSource 来读取
 *
 *  @param dataSource 数据源数组
 *
 *  @return 数据源数组，可以添加自己定义的数据源item
 */
-(NSMutableArray*)willReloadTableData:(NSMutableArray*)dataSource;

#pragma mark override
/**
 *  将要显示会话列表单元，可以有限的设置cell的属性或者修改cell, 子类重写该方法后可以实现在cell加载之前将修改的属性加载到tableView. 例如：setHeaderImagePortraitStyle
 *
 *  @param cell      cell
 *  @param indexPath 索引
 */
-(void)willDisplayConversationTableCell:(RCConversationBaseCell*)cell atIndexPath:(NSIndexPath *)indexPath;
#pragma mark override
/**
 *  重写方法，可以实现开发者自己添加数据model后，返回对应的显示的cell
 *
 *  @param tableView 表格
 *  @param indexPath 索引
 *
 *  @return RCConversationBaseTableCell
 */
- (RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark override
/**
 *  重写方法，可以实现开发者自己添加数据model后，返回对应的显示的cell的高度
 *
 *  @param tableView 表格
 *  @param indexPath 索引
 *
 *  @return 高度
 */
- (CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark override
/**
 *  重写方法，点击tableView删除按钮触发事件
 *
 *  @param tableView    表格
 *  @param editingStyle 编辑样式
 *  @param indexPath    索引
 */
- (void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark override
/**
 *  点击头像事件
 *
 *  @param userId 用户的ID
 */
- (void) didTapCellPortrait:(NSString*)userId;

/**
 *  子类重写该方法用于监听收到的新消息，需要调用super 方法来实现父类的数据刷新
 *
 *  @param notification notification
 */
(void) didReceiveMessageNotification:(NSNotification*)notification;

RCConversationBaseCell
@Description: 会话列表Cell的基类，自定义Cell需要从这个基类来继承

@property
/**
 * 当前Cell的会话数据模型
 *
 *  @param RCConversationModel model
 */
@property (nonatomic ,strong) RCConversationModel *model;

/**
 *  子类需要重写该方法来实现根据传入的会话数据模型更新Cell UI
 *
 *  @param notification notification
 */
-(void)setDataModel:(RCConversationModel*)model;
会话列表中，如会话显示的最后一条消息为自定义消息时，可通过实现 RCMessageContentView 协议来展现该会话摘要。
会话界面自定义
点击会话列表中某一会话后开启会话界面，在会话界面中为满足开发者改变界面样式需求，已实现包括：消息展示自定义、输入框自定义、功能板自定义等自定义功能。
会话列表自定义请参见：RCConversationViewController
消息继承体系，继承RCMessageContent，实现编码解码协议RCMessageCoding和持久化协议RCMessagePersistentCompatible 实现这两个协议，主要实现以下几个方法。
/**
    编码将当前对象转成JSON数据
    @return 编码后的JSON数据
 */
- (NSData *)encode;
/**
    根据给定的JSON数据设置当前实例
    @param data 传入的JSON数据
 */
- (void)decodeWithData:(NSData *)data;

/**
    应返回消息名称，此字段需个平台保持一致，每个消息类型是唯一的
    @return 消息体名称
 */
(NSString *)getObjectName;
/**
    返回遵循此protocol的类对象持久化的标识

    @return 返回持久化设定标识
    @discussion   默认实现返回 @const (MessagePersistent_ISPERSISTED | MessagePersistent_ISCOUNTED)
*/
+(RCMessagePersistent)persistentFlag;
这样，自定义的消息就实现了。同时，自定义消息不要忘记注册。如果服务器发送一个客户端没有实现的消息，我们的sdk会自动转换成RCUnknownMessage。
/**
 *  注册消息类型，如果不对消息类型进行扩展，可以忽略此方法。
 *
 *  @param messageClass   消息类型名称，对应的继承自 RCMessageContent 的消息类型。
 */

-(void)registerMessageType:(Class)messageClass;
输入框自定义
在会界面中可以设置输入框的模式。针对聊天会话的语音/文本切换功能、内容输入功能、扩展功能，融云目前提供了 9 种排列组合模式：
style 样式枚举	组合模式
RC_CHAT_INPUT_BAR_STYLE_SWITCH_CONTAINER_EXTENTION	语音/文本切换功能+内容输入功能+扩展功能
RC_CHAT_INPUT_BAR_STYLE_EXTENTION_CONTAINER_SWITCH	扩展功能+内容输入功能+语音/文本切换功能
RC_CHAT_INPUT_BAR_STYLE_CONTAINER_SWITCH_EXTENTION	内容输入功能+语音/文本切换功能+扩展功能
RC_CHAT_INPUT_BAR_STYLE_CONTAINER_EXTENTION_SWITCH	内容输入功能+扩展功能+语音/文本切换功能
RC_CHAT_INPUT_BAR_STYLE_SWITCH_CONTAINER	语音/文本切换功能+内容输入功能
RC_CHAT_INPUT_BAR_STYLE_CONTAINER_SWITCH	内容输入功能+语音/文本切换功能
RC_CHAT_INPUT_BAR_STYLE_EXTENTION_CONTAINER	扩展功能+内容输入功能
RC_CHAT_INPUT_BAR_STYLE_CONTAINER_EXTENTION	内容输入功能+扩展功能
RC_CHAT_INPUT_BAR_STYLE_CONTAINER	内容输入功能

语音/文本切换功能+内容输入功能+扩展功能 组合示例
组合模式可通过 RCChatSessionInputBarControl.setInputBarType 方法设置 style 样式实现。
如果需要默认显示语音输入，可继承我们的会话界面 RCConversationViewController，在 viewDidLoad 里加上 self.defaultInputType = RCChatSessionInputBarInputVoice; 打开会话界面时，默认就是语音输入功能。
/**
 *  设置输入栏的样式 可以在viewdidload后，可以设置样式
 *
 *  @param style 样式
 */
-(void)setInputBarType:(RCChatSessionInputBarControlType)type
                 style:(RCChatSessionInputBarControlStyle)style;
扩展功能自定义
扩展功能在已默认支持照片、拍照、地理位置、语音通话等功能的情况下，新增自定义功能，如开发者插入自己的默认表情包等。
可通过向 RCPluginBoardView 添加功能项实现。

扩展功能示例
扩展功能设置可通过 RCPluginBoardView 中的 insertItemWithImage 和 RCPluginBoardViewDelegate 方法设置。
/**
 *  添加扩展项，在会话中，可以在viewdidload后，向RCPluginBoardView添加功能项
 *
 *  @param image 图片
 *  @param title 标题
 *  @param index 索引
 */
-(void)insertItemWithImage:(UIImage*)image title:(NSString*)title atIndex:(NSInteger)index;

重新实现方法
/**
 *  点击事件
 *
 *  @param pluginBoardView 功能模板
 *  @param index           索引
 */
-(void)pluginBoardView:(RCPluginBoardView*)pluginBoardView clickedItemAtIndex:(NSInteger)index;
消息展示自定义
消息展示自定义基于 UICollectionView 研发，每一个消息对应一个消息展现。
消息展现根据需求继承融云提供的两个模板 RCMessageBaseCell 和 RCMessageCell。前者不包含头像，主要用于公众平台消息。后者已经实现了头像和发送状态主要用于会话聊天。

UI 会话界面自定义
//自定义消息展示后，需要调用方法注册。
/**
 *  注册消息Cell
 *
 *  @param cellClass  cellClass
 *  @param identifier identifier
 */
- (void) registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

实现以下几个委托方法
/**
 *  重写方法实现自定义消息的显示
 *
 *  @param collectionView collectionView
 *  @param indexPath      indexPath
 *
 *  @return RCMessageTemplateCell
 */
(RCMessageBaseCell *) rcConversationCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  重写方法实现自定义消息的显示的高度
 *
 *  @param collectionView       collectionView
 *  @param collectionViewLayout collectionViewLayout
 *  @param indexPath            indexPath
 *
 *  @return 显示的高度
 */
(CGSize) rcConversationCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
此外，每一个消息cell将要展示的时候，将会触发
/**
 *  将要显示会话消息，可以修改RCMessageBaseCell的头像形状，添加自定定义的UI修饰
 *
 *  @param cell      cell
 *  @param indexPath indexPath
 */
(void) willDisplayConversationTableCell:(RCMessageBaseCell*)cell atIndexPath:(NSIndexPath *)indexPath;
可以根据需要对消息展示进行修改和装饰。
自定义消息展示高度计算模型：
RCMessageBaseCell

RCMessageCell

是否显示时间 RCMessageModel 的属性 isDisplayMessageTime 决定
是否显示昵称 RCMessageModel 的属性 isDisplayNickname 决定
详细请参见，自定义消息类型及展示代码示例
配置应用
应用标识
应用标识是为了我们的 API 能够正确识别并验证您的应用请求而所必要的信息，对于防止账户盗用和滥用有着重要的作用。针对 iOS 平台，需要填写 Bundle Identifier，在 XCode 中的位置如图所示。

Bundle Identifier 位置
如果您只是采用开发环境 App Key / Secret 进行测试开发，暂时不需要填写相关信息；但是您在提请应用上线前必须完善应用配置信息，否则无法提请上线。
请务必确保您填写的 Bundle Identifier 信息和您应用程序包中的信息一致。上线后，每次连接我们都将会验证这个信息，如果信息不一致，服务端将会拒绝接受连接，您的 App 将无法使用融云的相关服务。
讨论组人数上限设置
讨论组人数在服务端有上限限制，为 500 人，在客户端，根据具体的业务需求，可以通过配置文件配置讨论组人数上限，配置的方法如下：
设置定义在 RCSelectPersonViewController.h 文件中，开发时请设置相关值：
/**
 *  讨论组人员最大限制，默认50个
 */
@property (nonatomic,assign) NSInteger discussion_members_limit;
iOS 推送证书设置
如果您希望您的 iOS 应用程序具备接收推送的能力，您必须要上传 iOS 推送证书（.p12 格式）。
iOS 推送证书设置步骤：
•	创建应用程序 ID
•	配置和下载证书
•	导出 .p12 证书文件
•	上传证书
1、创建应用程序 ID
登陆 iOS Dev Center 选择进入 iOS Provisioning Portal。

在 iOS Provisioning Portal 中，点击 App IDs 进入 App ID 列表。

创建 App ID，如果 ID 已经存在可以直接跳过此步骤

为 App 开启 Push Notification 功能。如果是已经创建的 App ID 也可以通过设置开启 Push Notification 功能。

根据实际情况完善 App ID 信息并提交,注意此处需要指定具体的 Bundle ID 不要使用通配符。

2、配置和下载证书
如果您之前没有创建过 Push 证书或者是要重新创建一个新的，请在证书列表下面新建。

新建证书需要注意选择证书种类（开发证书用于开发和调试使用，生产证书用于 App Store 发布）

点击 Continue 后选择证书对应的应用 ID，然后继续会出现 About Creating a Certificate Signing Request (CSR)。

根据它的说明打开 Keychain Access 创建 Certificate Signing Request。

填写 User Email Address 和 Common Name 后选择 Saved to disk 进行保存 。

继续返回 Apple developer 网站点击 Continue ，上传刚刚生成的 .certSigningRequest 文件生成 APNs Push Certificate。 下载并双击打开证书，证书打开时会启动 钥匙串访问 工具。 在 钥匙串访问 中您的证书会显示在 我的证书 中，注意选择 My Certificates 和 login

3、导出 .p12 证书文件
在 钥匙串访问 中，选择刚刚加进来的证书，选择右键菜单中的 Export "Apple ..."。

将文件保存为 Personal Information Exchange (.p12) 格式。

保存 p12 文件时，可以为其设置密码，也可以让密码为空。
4、上传证书
在 融云开发者平台 选择需要 push 推送消息的应用在应用标识模块中，上传上面步骤得到 .p12 证书文件，上传成功后才能收到融云 Push 推送消息。

Demo 示例
为了您能够更好的理解如何使用融云 IMKit SDK，我们在 GitHub 上提供了开源的 Demo App。
Demo App 中使用了我们提供的 App Key，Demo App 连接的是我们为了演示用搭建的 Demo App Server，Demo App Server 中使用了和 Demo App 相同的 App Key / App Secret。如果您只更换了 Demo App 的 App Key 为自己申请的 App Key，是无法成功连接到我们的 Demo App Server 的。这种情况下，您需要自己架设您自己的 Demo App Server 并正确设置其中的 App Key / App Secret。
请移步访问：
https://github.com/rongcloud/demo-app-ios-v2
https://github.com/rongcloud/demo-server-php
https://github.com/rongcloud/demo-server-nodejs

