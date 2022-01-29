# UIWebView

## 加载文件

## 与 js 交互

### OC 调用 JS

```objc
// 执行 js
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title;"];
    NSLog(@"%@", title);

    [webView stringByEvaluatingJavaScriptFromString:@"clickme();"];
}
```

### JS 调用 OC

#### 准备代码
```objc
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    NSLog(@"%@", request.URL);

    return YES;
}
```

> 在 OC 中，如果代理方法返回 BOOL 类型，返回 YES 会正常执行

#### 解释自定义协议

```
href="myfunc:///showMessage:/晚上请你吃饭:D"

调用 OC 中的方法 `showMessage:` 显示内容 `晚上请你吃饭:D`
```

#### 代码实现

```objc
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    NSLog(@"%@", request.URL.scheme);

    if ([request.URL.scheme isEqualToString:@"myfunc"]) {

        NSLog(@"%@", request.URL.pathComponents);

        NSArray *components = request.URL.pathComponents;

        NSString *funcName = components[1];
        NSString *param = components[2];

        SEL func = NSSelectorFromString(funcName);
        [self performSelector:func withObject:param];
    }

    return YES;
}
```

#### 代码细节

```objc
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    NSLog(@"%@", request.URL.scheme);

    if ([request.URL.scheme isEqualToString:@"myfunc"]) {

        NSLog(@"%@", request.URL.pathComponents);

        NSArray *components = request.URL.pathComponents;
        if (components.count != 3) {
            return NO;
        }

        NSString *funcName = components[1];
        NSString *param = components[2];

        SEL func = NSSelectorFromString(funcName);

        if ([self respondsToSelector:func]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:func withObject:param];
#pragma clang diagnostic pop
        }

        return NO;
    }

    return YES;
}
```


