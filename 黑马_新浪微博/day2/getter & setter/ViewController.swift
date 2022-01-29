//
//  ViewController.swift
//  getter & setter
//
//  Created by 翟佳阳 on 2021/11/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let p = Person()
        p.name = "爱不爱"
        
        print(p.name!)
        // 计算型属性
        print(p.title2!)
        // 懒加载
        print(p.title3!)
        
        print("----")
        p.name = nil
//        p.name = "里斯"
        
        // 计算型属性
        print(p.title2!)
        // 懒加载
        print(p.title3!)
    }


}

