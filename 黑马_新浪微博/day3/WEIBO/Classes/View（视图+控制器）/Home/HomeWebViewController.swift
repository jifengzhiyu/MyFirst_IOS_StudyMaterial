//
//  HomeWebViewController.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/12/25.
//

import UIKit

class HomeWebViewController: UIViewController {

    private lazy var webView = UIWebView()
    private var url: NSURL
    
    // MARK: - 构造函数
    init(url: NSURL) {
        self.url = url
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = webView
        
        title = "网页"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadRequest(NSURLRequest(url: url as URL) as URLRequest)
    }
}
