//
//  ViewController.swift
//  循环
//
//  Created by 翟佳阳 on 2021/11/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        demo()
    }

    func demo() {
        
        // 定义范围 0~8
        for i in 0..<9 {
            print(i)
        }
        
        // ---
        print("---------")
        
        // 定义范围 0~9
        for i in 0...9 {
            print(i)
        }
        
        let r1 = 0..<9
        print(r1)
        
        let r2 = 0...9  // 0..<10
        print(r2)
    }
}

