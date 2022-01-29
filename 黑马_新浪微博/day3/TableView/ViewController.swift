//
//  ViewController.swift
//  TableView
//
//  Created by 翟佳阳 on 2021/11/22.
//

import UIKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        // 在实例化 tableView 的时候，需要指定样式，指定之后，不能在修改
        let tb = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        //设置数据源
        tb.dataSource = self
        
        // 注册可重用 cell [UITableViewCell class]
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return tb
    }()
    
    // 是用纯代码创建视图层次结构 － 和 storyboard / xib 等价
    override func loadView() {
        // 在访问 view 的时候，如果 view == nil，会自动调用 loadView 方法
        // print(view)
        
        // 设置视图，让 view == tableView
        view = tableView
        
//        print(view!)
//        print(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

// 将一组相关的代码放在一起，便于阅读和维护
//MARK: 数据源extensione
// 在 OC 中遵守协议 <UITableViewDataSource>
// 在 Swift 中，遵守协议的写法，类似于其他语言中的多继承
// 面试题：OC中，有多继承吗？如果没有，如何替代！

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 43
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 使用此方法，必须注册可重用 cell，此方法是在 iOS 6.0 推出的，替代以下三行代码
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = "hiii \(indexPath.row)"
        cell.contentConfiguration = content
        
        return cell
}
}

