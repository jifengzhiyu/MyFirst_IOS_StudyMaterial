    //
    //  Model.swift
    //  swift归档接档
    //
    //  Created by 翟佳阳 on 2021/11/29.
    //

import UIKit
// model 模型中必须继承 nsobject + 遵守coding 协议+ 安全编码协议
//而且我标记了这个为 @objc oc 的类
//因为解档归档这玩意是 oc 的产物
@objc class Model: NSObject, NSCoding, NSSecureCoding{
        
    var name: String?
    var age: Int?
    
    static var supportsSecureCoding: Bool = true
    
    override init() {
        super.init()
    }
    
    // MARK: - 保存当前对象
    // 给自己的对象增加一个保存方法, 封装在 model 内部, 当然也可以随便写在啥地方
       func saveModel(){
           // 1. 保存路径
           let path = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!).appendingPathComponent("model.plist")

           // 2、在实际开发中，一定要确认文件真的保存了！
           print(path ?? "")
           
           // 3. 归档保存
           do{
           let userData = try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)
           try userData?.write(to: path!)
               print("Saved")
           }catch let error as NSError{
               print("\(error)")
           }
       }
    
        // MARK: - `键值`归档和解档
        /// 归档 - 在把当前对象保存到磁盘前，将对象编码成二进制数据 － 跟网络的序列化概念很像！
        /// - parameter Coder: 编码器
    // 将自己的模型的属性编码 + key
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(age, forKey: "age")
    }
    
    
    
        /// 解档 - 从磁盘加载二进制文件，转换成对象时调用 － 跟网络的反序列化很像
        /// - parameter coder: 解码器
        /// - returns: 当前对象
        /// `required` - 没有继承性，所有的对象只能解档出当前的类对象
    /// // 解档的时候给模型赋值
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String
        age = coder.decodeObject(forKey: "age") as? Int
    }
}
