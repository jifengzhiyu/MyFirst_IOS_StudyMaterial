//
//  ViewController.swift
//  Alamofire_learn
//
//  Created by 翟佳阳 on 2021/12/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        demoGet()
        
//        demoPost()
        
        demoUpload()
        
        
        
        
    }
    
     func demoUpload(){
        struct DecodableType: Decodable { let url: String }

        /*
         appendbody,方法中,如果带 mimetype是拼接上传文件的方法 appendbody,如果不带 mimetype是拼接普通的二进制参数方法!
         */
        AF.upload(multipartFormData: { multipartFormData in
            //mimeType不需要服务器知道用
//            拼接上传文件的二进制数据
            multipartFormData.append(Data("tria".utf8), withName: "Greek", fileName: "MyEllinika", mimeType: "application/octet-stream")
//            拼接普通的二进制参数方法!
            multipartFormData.append(Data("one".utf8), withName: "one")
            multipartFormData.append(Data("two".utf8), withName: "two")
            
        }, to: "https://httpbin.org/post")
            .responseDecodable(of: DecodableType.self) { response in
                switch response.result {
                case .success:
                    print("success")
                    print("-----------------------")
                    debugPrint(response)
                case let .failure(error):
                print("failure: \(error)")
            }
    }
     }
    
        func demoPost(){
        // 显示网络指示器
        
        AF.request("https://httpbin.org/post",
                   method: .post,
                   headers: ["User-Agent" : "iPhone"]).responseString { myResponse in
            // 输出字符串的响应结果
//            debugPrint(myResponse.value)
            let str :String? = myResponse.value
            let strM :[String]? = str?.components(separatedBy: "\n")
            guard (strM != nil) else{
                return
            }
            for strS in strM! {
//                就是反序列化完成的 字典 / 数组
                print(strS)
            }
        }
    }
    
        func demoGet(){
        
        AF.request("https://httpbin.org/get", method: .get, parameters: ["name" : "zhang"]).response { myResponse in
//            debugPrint(myResponse)
            
//            switch myResponse.result {
//                       case .success:
//                           print("success")
//                       case let .failure(error):
//                           print("failure: \(error)")
//                       }
            
        }
        
        // 1. request 只是建立一个网络请求，如果没有后续方法，就什么都不做
        // 2. 所有要告诉服务器的额外信息，可以通过 header 字典参数设置
        //      可以设置 User-Agent / Authorization / Cookie...
        // 3. 如果服务器支持的编码格式不是 UTF8，可以通过 encoding 指定
        // 4. `链式`响应
        AF.request("https://httpbin.org/get",
                   method: .get,
                   headers: ["User-Agent" : "iPhone"]).responseString { myResponse in
            // 输出字符串的响应结果 
//            debugPrint(myResponse.value)
            let str :String? = myResponse.value
            let strM :[String]? = str?.components(separatedBy: "\n")
            guard (strM != nil) else{
                return
            }
            for strS in strM! {
//                就是反序列化完成的 字典 / 数组
                print(strS)
            }
        }
        
//        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.baidu.com")! as URL)
//        // 所有要告诉服务器的额外信息，都通过 forHTTPHeaderField 设置
//         request.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
       
        }
}

