//
//  DemoViewController.swift
//  OC单例
//
//  Created by 翟佳阳 on 2021/11/25.
//

import UIKit

class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(SoundTools.sharedTools3)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(SoundTools.sharedTools4)
        print(NetWorkTools.shared())
        print("aaaaaaaa")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
