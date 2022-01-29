//
//  ViewController.swift
//  封装_AFN框架_swift
//
//  Created by 翟佳阳 on 2021/11/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         
        NetworkTools.sharedTools.request(method: .GET, URLString: "http://httpbin.org/get", parameters: ["name" : "abababa"]) { result, error in
            print(result ?? "")

        }
        
//        NetworkTools.sharedTools.request(method: .GET, URLString: "http://httpbin.org/get", parameters: ["name" : "abababa"]) { result, error in
//            print(result ?? "")
//
//        }
        
        
//        print(NetworkTools.sharedTools)
//        NetworkTools.sharedTools.request(URLString: "http://www.weather.com.cn/data/sk/101010100.html", parameters: [:])
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(NetworkTools.sharedTools)

    }
}

