//
//  VisitorTableViewController.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/11/24.
//

import UIKit

class VisitorTableViewController: UITableViewController {

    //用户登录标记
//    private var userLogon = UserAccountViewModel.sharedUserAccount.userLogon

    private var userlogon = true

    
    /// 访客视图
    var visitorView: VisitorView?
    
    
    //检测是否成功加载
    override func loadView() {
        print("即将判断是否 加载访问者视图")
//        super.loadView()
        // 根据用户登录情况，决定显示的根视图
        userlogon ? super.loadView() : setUpVisitorView()
        
    }
    
    //检验有几个visitorview
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(visitorView ?? "nil")
    }
    
    ///设置访客视图
    private func setUpVisitorView(){
     
        //tableView-->UIView
        
        visitorView = VisitorView()
        
        // 设置代理
//        visitorView?.delegate = self
        
        self.view = visitorView
//        view.backgroundColor = .orange
        
        // 添加监听方法
        visitorView?.registerButton.addTarget(self, action: #selector(self.visitorViewDidRegister), for: UIControl.Event.touchUpInside)
        visitorView?.loginButton.addTarget(self, action: #selector(self.visitorViewDidLogin), for: UIControl.Event.touchUpInside)
        
        // 设置导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(self.visitorViewDidRegister))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(self.visitorViewDidLogin))
        
    }
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

   

}


// MARK: - 访客视图监听方法
extension VisitorTableViewController
//:VisitorViewDelegate
{
    @objc func visitorViewDidLogin() {
        print("login")
        let vc = OAuthViewController()
        vc.view.backgroundColor = .white
        
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true, completion: nil)
    }
    
    @objc func visitorViewDidRegister() {
        print("register")
    }
    
}
