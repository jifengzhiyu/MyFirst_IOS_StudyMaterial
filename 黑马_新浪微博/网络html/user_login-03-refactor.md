# 代码重构

## 1. 单例

```objc
+ (instancetype)sharedNetworkTools {
    static id instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });

    return instance;
}
```

## 2. 代码重构

### 1> 复制主方法

```objc
- (void)userLogin {
    NSString *pwd = [self timePassword];

    NSLog(@"发送的密码是 %@", pwd);

    NSURL *url = [NSURL URLWithString:@"http://localhost/loginhmac.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    request.HTTPMethod = @"POST";
    NSString *bodyStr = [NSString stringWithFormat:@"username=%@&password=%@", self.username, pwd];
    request.HTTPBody = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"%@ - %@", response, result);

        if ([result[@"userId"] intValue] > 0) {
            [self saveUserInfo];
        }
    }];
}
```

### 2> 添加属性

```objc
///  用户名
@property (nonatomic, copy) NSString *username;
///  用户密码
@property (nonatomic, copy) NSString *pwd;
```

### 3> 复制相关方法

```objc
#pragma mark - 私有方法
- (NSString *)timePassword {
    // 1. 生成key
    NSString *key = @"itheima".md5String;
    NSLog(@"HMAC Key - %@", key);

    // 2. 对密码进行 hmac 加密
    NSString *pwd = [self.pwd hmacMD5StringWithKey:key];

    // 3. 获取服务器系统时间
    NSURL *url = [NSURL URLWithString:@"http://localhost/hmackey.php"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSString *dateStr = dict[@"key"];
    NSLog(@"%@", dateStr);

    // 4. 将系统时间拼接在第一次加密密码的末尾
    pwd = [pwd stringByAppendingString:dateStr];

    // 5. 返回拼接结果的再次 hmac
    return [pwd hmacMD5StringWithKey:key];
}

#pragma mark - save & load user info
#define HMUsernameKey @"HMUsernameKey"
#define HMUserPasswordKey @"HMUserPasswordKey"
///  保存用户信息
- (void)saveUserInfo {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // iOS 8.0 会直接写入沙盒，无需再使用 `[defaults synchronize];`
    [defaults setObject:self.username forKey:HMUsernameKey];

    // 将用户密码保存在钥匙串
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    [SSKeychain setPassword:self.pwd forService:bundleId account:self.username];
}
```

### 4> 开放主方法

```objc
/// 用户登录
- (void)userLogin;
```

### 5> 在 AppDelegate 中调用用户登录

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 用户登录
    [[NetworkTools sharedNetworktools] userLogin];

    return YES;
}
```

> 运行测试，发现没有加载用户信息

### 6> 复制加载用户信息方法

```objc
///  加载用户下信息
- (void)loadUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    self.username = [defaults stringForKey:HMUsernameKey];

    NSLog(@"%@", [SSKeychain allAccounts]);
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    self.pwd = [SSKeychain passwordForService:bundleId account:self.username];
}
```

### 7> 在 `单例` 方法中加载用户信息

```objc
+ (instancetype)sharedNetwrokTools {
    static id instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance loadUserInfo];
    });
    return instance;
}
```

### 8> 增加判断，如果没有用户信息直接返回

```ojbc
- (void)userLogin {

    if (self.pwd == nil || self.username == nil) {
        return;
    }
```

### 9> 切换界面

* 定义通知字符串

```objc
#define HMUserLoginStatusChangedNotification @"HMUserLoginStatusChangedNotification"
```

* 登录成功发布通知

```objc
// 发送通知
[[NSNotificationCenter defaultCenter] postNotificationName:HMUserLoginStatusChangedNotification object:@"Main"];
```

* 注册通知

```objc
// 注册通知
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChanged:) name:HMUserLoginStatusChangedNotification object:nil];
```

* 登录状态变化更改界面

```objc
- (void)loginStatusChanged:(NSNotification *)n {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:n.object bundle:nil];
    self.window.rootViewController = sb.instantiateInitialViewController;
}
```

* 用户注销

```objc
- (IBAction)logout:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:HMUserLoginStatusChangedNotification object:@"Login"];
}
```

### 10> 调整登录视图控制器

```objc
#import "NetworkTools.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadUserInfo];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameText) {
        [self.pwdText becomeFirstResponder];
    } else {
        [self userLogin];
    }
    return YES;
}

- (IBAction)userLogin {
    NetworkTools *tools = [NetworkTools sharedNetwrokTools];

    tools.username = self.usernameText.text;
    tools.pwd = self.pwdText.text;

    [tools userLogin];
}

#pragma mark - save & load user info
///  加载用户下信息
- (void)loadUserInfo {
    NetworkTools *tools = [NetworkTools sharedNetwrokTools];

    self.usernameText.text = tools.username;
    self.pwdText.text = tools.pwd;
}
```

### 11> 失败回调

* 修改登录方法

```objc
///  用户登录
- (void)userLoginFailed:(void (^)())failed;
```

* 增加回调代码

```objc
if (failed) {
    failed();
}
```

* 修改调用代码

```objc
[tools userLoginFailed:^{
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码错误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}];
```

### 12> 取消默认启动控制器

* 实例化 windows

```objc
self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
self.window.backgroundColor = [UIColor whiteColor];
[self.window makeKeyAndVisible];
```

* 修改登录方法

```objc
[[NetworkTools sharedNetwrokTools] userLoginFailed:^{
    NSNotification *n = [NSNotification notificationWithName:HMUserLoginStatusChangedNotification object:@"Login"];
    [self loginStatusChanged:n];
}];
```

### 其他

* 通知方法执行所在线程与发布通知的线程一致
* `extern` 定义字符串常量更安全，是绝大多数 C 语言程序采用的解决方案

```objc
///  用户状态变化通知
extern NSString * const HMUserLoginStatusChangedNotification;

NSString * const HMUserLoginStatusChangedNotification = @"HMUserLoginStatusChangedNotification";
```
