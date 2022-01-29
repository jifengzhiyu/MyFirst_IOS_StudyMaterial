//
//  ViewController.swift
//  TextKit
//
//  Created by 翟佳阳 on 2021/12/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: DemoLabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        label.text =
        "http://www.apple.com,,http://www.t.cn"

    }


}

