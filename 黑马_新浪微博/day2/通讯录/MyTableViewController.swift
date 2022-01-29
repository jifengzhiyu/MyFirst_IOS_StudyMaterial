//
//  MyTableViewController.swift
//  通讯录
//
//  Created by 翟佳阳 on 2021/11/20.
//

import UIKit

class MyTableViewController: UITableViewController {

    //数据数组
    private var persons: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("111111")

        loadData(complection: { array in
//            print(array)
            // 记录接受到回调参数
            self.persons = array
            // 刷新表格
            self.tableView.reloadData()
        })
        
    }
    
    //MARK: 从一个 vc 跳转到 另一个 vc 调用的方法
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1. 拿到目标控制器
        guard let detailVC = segue.destination as? DetailViewController else {
                    return
                }
        
                // 2. 获取用户当前选中行数据
                guard let indexPath = tableView.indexPathForSelectedRow else {
                    return
                }
        
                // detailVC & indexPath 全部拿到
                // 3. 根据 indexPath 获取 person 数据
                print(persons![indexPath.row])
        
                // 4. 传递数据
                // 1> 个人记录
                detailVC.person = persons![indexPath.row]
//                // 2> 完成回调
//                detailVC.didSaveCallBack = {
//                // 刷新表格
//                self.tableView.reloadData()
        //}
        //闭包实际上传递一个可以执行的函数
        // 简写 － 传递了一个`可以执行的`函数
        detailVC.didSaveCallBack = self.tableView.reloadData
    }
}
    

   




// MARK: - 数据源方法
extension MyTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        // 如果 persons 数组为nil，直接返回0
        return persons?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 模型查询可重用 cell 返回 UITableViewCell，没有 PersonCell 的属性
        // 使用 as 转换类型
        // 通常使用 as 的时候，需要使用 ?/! => 根据前面函数的返回值来决定
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PersonCell

//        var content = cell.defaultContentConfiguration()
//
//        //这里api更新了https://www.jianshu.com/p/e8843595a794
//        content.text = persons![indexPath.row].name
//
//        cell.contentConfiguration = content
//        print(content.text!)
        
        cell.person = persons![indexPath.row]
        return cell
    }
    
}

// MARK: - 数据处理
// extension 类似于 OC 中的分类，可以将控制器的代码分组，便于维护和管理
    extension MyTableViewController{
        //https://www.cnblogs.com/liuw-flexi/p/12869541.html
        //逃逸闭包
        /*
         一般在定义网络请求框架时，会声明成功闭包，失败闭包。用来回调返回的数据给调用者。
         成功闭包，失败闭包当然是作为请求方法的参数，这时候会报错，因为这种闭包必须声明为逃逸闭包。
         也就是在闭包类型前加 @escaping
         */
        func loadData(complection: @escaping([Person]) -> ()){
        //CGD
        //https://www.jianshu.com/p/e8bf8c2a5352
        let queue = DispatchQueue.global()
//        print("begin = \(Thread.current)")
        
        queue.async {
            Thread.sleep(forTimeInterval: 2)
//            print("1 -- \(Thread.current)")
            print("耗时操作")
            
            //1、创建数组 元素是person的数组
            var dataList = [Person]()
            
            //2、循环生成数据
            for i in 0 ..< 50{
                let name = "粑粑 \(i)"
                let age = i
                
                let dict: [String : Any] = ["name" : name, "age" : age]
                
                //字典转模型，加到数组
                dataList.append(Person(dict: dict))
            }
            
            //3、测试
//            print(dataList)
            
            let queue1 = DispatchQueue.main
            queue1.async {
//                print("2 -- \(Thread.current)")
                //完成回调
                print("完成回调")
                complection(dataList)
            }
        }
        
    }
    
    
   

   
}
