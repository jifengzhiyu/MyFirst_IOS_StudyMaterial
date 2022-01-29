//
//  OAuthViewController.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/11/28.
//

import UIKit
import SVProgressHUD
class OAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    //MARK: -监听方法
    @objc private func close(){
//        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
     
    /// 自动填充用户名和密码 － web 注入（以代码的方式向web页面添加内容）
    @objc private func autoFill() {
        
        let js = "document.getElementById('userId').value = 'daoge10000@sina.cn';" +
            "document.getElementById('passwd').value = 'qqq123';"
        
        // 让 webView 执行 js
        webView.stringByEvaluatingJavaScript(from: js)
    }
    
    //MARK: -设置界面
    override func loadView() {
        view = webView
        webView.delegate = self
        
        //设置导航栏
        title = "新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(self.close))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .plain, target: self, action: #selector(self.autoFill))

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.loadRequest(NSURLRequest(url: NetworkTools.sharedTools.oauthURL as URL) as URLRequest)
        
        // Do any additional setup after loading the view.
    }

}

// MARK: - UIWebViewDelegate
extension OAuthViewController: UIWebViewDelegate {
    
    /// 将要加载请求的代理方法
    ///
    /// - parameter webView:        webView
    /// - parameter request:        将要加载的请求
    /// - parameter navigationType: navigationType，页面跳转的方式
    ///
    /// - returns: 返回 false 不加载，返回 true 继续加载
    /// 如果 iOS 的代理方法中有返回 bool，通常返回 true 很正常，返回 false 不能正常工作
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        // 目标：如果是百度，就不加载
        // 1. 判断访问的主机是否是 www.baidu.com
        
        guard let url = request.url, url.host == "www.baidu.com" else {
            return true
        }
        
        // 2. 从百度地址的 url 中提取 `code=` 是否存在
        guard let query = url.query, query.hasPrefix("code=") else {
            print("取消授权")
            self.close()
            return false
        }
        
        // 3. 从 query 字符串中提取 `code=` 后面的授权码
        let code = query.substring(from: "code=".endIndex)
        print(query)
        print("授权码是 " + code)
        
//        //主机地址
//        print(url.host!)
//        //查询字符串
//        print(url.query!)
        
//        print(request)
        // 4. 加载 accessToken
        
        UserAccountViewModel.sharedUserAccount.loadAccessToken(code: code) { (isSuccessed) -> () in
            
            // finished 的完整代码
            if !isSuccessed {
                print("失败了")
                SVProgressHUD.showInfo(withStatus: "网络不好")
                delay(delta: 0.5) {
                    self.close()
                }
                return
            }
            
            print("成功了")
            
            // dismissViewControllerAnimated 方法不会立即将控制器销毁
            self.dismiss(animated: false){
                //                print(UserAccountViewModel.sharedUserAccount.account ?? "")
                //发送通知
                // 通知中心是同步的 - 一旦发送通知，会先执行监听方法，直接结束后，才执行后续代码

                NotificationCenter.default.post(name:NSNotification.Name.init(rawValue: WBSwitchRootViewControllerNotification) , object: "welcome")
                
                // 停止指示器
                SVProgressHUD.dismiss()
            }
        }
        
        return false
    }
    
    
    //使用会报错
//    func webViewDidStartLoad(_ webView: UIWebView) {
//        SVProgressHUD.show()
//    }
//
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//        SVProgressHUD.dismiss()
//    }
}
