//
//  ViewController.swift
//  时间
//
//  Created by 翟佳阳 on 2021/12/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        demo()
        
//        let str = "Sat Oct 31 11:28:49 +0800 2015"
//        print(NSDate.sinaDate(string: str) ?? "")
        
        // 目标：特殊格式的字符串
        // 步骤
        // 1. 建立`日期`对象
        // 2. 根据日期对象，计算显示描述字符
        print(NSDate.sinaDate(string:"Dec 24 20:41:49 +0800 2021")?.dateDescription ?? "")
        print(NSDate.sinaDate(string:"Dec 24 20:09:04 +0800 2021")?.dateDescription ?? "")
        
        print(NSDate.sinaDate(string:"Dec 24 15:00:49 +0800 2021")?.dateDescription ?? "")
        print(NSDate.sinaDate(string:"Dec 23 00:00:49 +0800 2021")?.dateDescription ?? "")
        
        print(NSDate.sinaDate(string:"Oct 30 11:28:49 +0800 2021")?.dateDescription ?? "")
        print(NSDate.sinaDate(string:"May 31 11:28:49 +0800 2015")?.dateDescription ?? "")
        
    }

    func demo() {
        let str = "Sat Oct 31 11:28:49 +0800 2015"
        
        // 1. 转换成日期
        let df = DateFormatter()
        
        df.locale = NSLocale(localeIdentifier: "en") as Locale
        //与字符串对应
        df.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        
        let date = df.date(from: str)
        print(date ?? "")
    }
    
    
}

