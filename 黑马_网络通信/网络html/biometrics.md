# 指纹识别 - 生物识别

## 简介

* iPhone 5S 开始支持
* iOS 8.0 开放了 Touch ID 的接口

## 代码准备

```objc
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self inputUserinfo];
}

///  输入用户信息
- (void)inputUserinfo {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"购买" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"购买", nil];
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;

    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%zd", buttonIndex);

    if (buttonIndex == 0) {
        return;
    }

    UITextField *usernameText = [alertView textFieldAtIndex:0];
    UITextField *pwdText = [alertView textFieldAtIndex:1];

    if ([usernameText.text isEqualToString:@"zhang"] && [pwdText.text isEqualToString:@"123"]) {
        [self purchase];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
    }
}

///  购买
- (void)purchase {
    NSLog(@"购买");
}
```

## 指纹识别

### 头文件

```objc
#import <LocalAuthentication/LocalAuthentication.h>
```

### 判断是否支持指纹识别

```objc
// 检查版本
if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
    [self inputUserinfo];
    return;
}

// 检查是否支持指纹识别
LAContext *ctx = [[LAContext alloc] init];

if ([ctx canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:NULL]) {
    NSLog(@"支持指纹识别");

    // 异步输入指纹
    [ctx evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"购买" reply:^(BOOL success, NSError *error) {
        NSLog(@"%d %@ %@", success, error, [NSThread currentThread]);
        if (success) {
            [self purchase];
        } else if (error.code == LAErrorUserFallback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self inputUserinfo];
            });
        }
    }];
    NSLog(@"come here");
} else {
    [self inputUserinfo];
}
```

## 错误代号

| 错误 | 描述 |
| -- | -- |
| LAErrorAuthenticationFailed | 指纹无法识别 |
| LAErrorUserCancel | 用户点击了"取消"按钮 |
| LAErrorUserFallback | 用户取消，点击了"输入密码"按钮 |
| LAErrorSystemCancel | 系统取消，例如激活了其他应用程序 |
| LAErrorPasscodeNotSet | 验证无法启动，因为设备上没有设置密码 |
| LAErrorTouchIDNotAvailable | 验证无法启动，因为设备上没有 Touch ID |
| LAErrorTouchIDNotEnrolled | 验证无法启动，因为没有输入指纹 |


## 使用 `UIAlertController`

```objc
- (void)inputUserInfo {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入用户名和口令" preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入用户名";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入用户密码";
        textField.secureTextEntry = YES;
    }];

    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"购买" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString *username = [alert.textFields[0] text];
        NSString *pwd = [alert.textFields[1] text];

        if ([username isEqualToString:@"zhang"] && [pwd isEqualToString:@"1"]) {
            [self purchase];
        } else {
            [self showErrorMsg];
        }
    }]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showErrorMsg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不正确" preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)purchase {
    NSLog(@"买了");
}
```
