    //
    //  ViewController.swift
    //  swift归档接档
    //
    //  Created by 翟佳阳 on 2021/11/29.
    //

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var infoLbl: UILabel!
    
    //MARK: 解档操作
    @IBAction func unarchBtnCli(_ sender: UIButton) {
        print("接档操作")
        
            // 获取文件路径 url
        let searchPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        let searchPathWithFile = (searchPath as NSString).appendingPathComponent("model.plist")
        let fileUrl = URL(fileURLWithPath: searchPathWithFile)
        
        var unarchModel: Model?
        
            // 尝试从 路径上获取 data 二进制流
        do {
            let data = try Data(contentsOf: fileUrl)
                // 从二进制流中解析 Model 对象
            unarchModel = try NSKeyedUnarchiver.unarchivedObject(ofClass: Model.self, from: data)
                //                    unarchModel = try NSKeyedUnarchiver.unarchiveObject(withFile: searchPathWithFile) as! Model
                // 旧版 api 已经被废弃 是直接从 file 里面解析
        } catch let err {
            print(err.localizedDescription)
        }
        
            // 判断解析出来的 model 是否为空 并更新 ui
        if nil != unarchModel {
            print("unarch => \(unarchModel?.name ?? "") + \(unarchModel?.age ?? 0)")
                // 更新 ui
            infoLbl.text = "==\(unarchModel?.name ?? "") + \(unarchModel?.age ?? 0)=="
        }
    }
    
    //MARK: 归档操作
    @IBAction func archBtnClicked(_ sender: Any) {
            // 实例化对象
        let demoModel = Model()
        
            // 赋值
        demoModel.name = "啊爸爸啊吧"
        demoModel.age = 250
        
            // 保存
        demoModel.saveModel()
        print("保存操作")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

