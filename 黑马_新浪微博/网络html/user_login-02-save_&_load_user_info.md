# 保存 & 加载用户信息

```objc
#define HMUsernameKey @"HMUsernameKey"
#define HMUserPasswordKey @"HMUserPasswordKey"
///  保存用户信息
- (void)saveUserInfo {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // iOS 8.0 会直接写入沙盒，无需再使用 `[defaults synchronize];`
    [defaults setObject:self.username forKey:HMUsernameKey];
    [defaults setObject:self.pwd forKey:HMUserPasswordKey];
}

///  加载用户下信息
- (void)loadUserInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    self.usernameText.text = [defaults stringForKey:HMUsernameKey];
    self.pwdText.text = [defaults stringForKey:HMUserPasswordKey];
}
```

> iOS 8.0 会直接写入沙盒，无需再使用 `[defaults synchronize];`
