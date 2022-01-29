//
//  ViewController.swift
//  网络_URLSession
//
//  Created by 翟佳阳 on 2021/11/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        
//           //发出请求
        // OC 中的按位枚举的方式改为数组的方式设置 [值1, 值2]
        //带throws的方法使用try
        // try! 程序员要负责，如果数据格式不正确，会崩溃！
        let urlString:String = "http://www.weather.com.cn/data/sk/101010100.html"
        var url:URL!
        url = URL(string:urlString)
        //发出请求
        URLSession.shared.dataTask(with: url) {(objectData, response, error) in
        guard error == nil else {
        print("网络出错:\(error!.localizedDescription)")
        return
        }
        guard objectData != nil else {
        print("数据为空：")
        return
        }


        do {
        let jsonData = try JSONSerialization.jsonObject(with: objectData!, options: .mutableContainers)
        print(jsonData)
            } catch {
                print("解析出错")
            }
        }.resume()

     //fcb-->vc
        

            
        
        
        
        
        
        
        
    }


}

