//
//  PersonCell.swift
//  通讯录
//
//  Created by 翟佳阳 on 2021/11/21.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var ageLable: UILabel!
    
    /// 个人模型 - Swift 中设置模型可以用 didSet
    var person:Person?{
        didSet{
            // 不需要使用 `_成员变量 = 变量`，因为已经完成设置了！
            
            // 当 person 模型被设置值完成后，执行的代码
            nameLable.text = person?.name
            //如果lbl出现optional，就需要把它改成必选 ?? 0
            ageLable.text = "\(person?.age ?? 0)"
        }
    }
}
