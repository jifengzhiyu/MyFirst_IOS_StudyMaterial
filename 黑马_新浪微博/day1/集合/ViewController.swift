//
//  ViewController.swift
//  集合
//
//  Created by 翟佳阳 on 2021/11/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        demo10()
        //把array1当作一个NSObject对象
        let array1 = ["网舞", "赵丽"] as NSObject
        //把array2的一个个元素当作 一个个NSObject对象
        let array2 = ["网舞", "赵丽"] as [NSObject]
        
//        Any:可以代表任意类型（枚举、结构体、类，也包括函数类型）
//        AnyObject:可以代表任意类 类型。
        
        //下面两个❌
    //        let array3: [NSObject] = ["网舞", "赵丽"]
    //        let array4: NSObject = ["网舞", "赵丽"]
        let array3: [NSObject] = ["网舞", "赵丽"] as [NSObject]
        let array4: NSObject = ["网舞", "赵丽"] as NSObject
        
        
        let array5 = ["网舞", "赵丽"] as [AnyObject]
        let array6 = ["网舞", "赵丽"] as AnyObject
        
        //下面两个❌
       //        let array7: [AnyObject] = ["网舞", "赵丽"]
       //        let array8: AnyObject = ["网舞", "赵丽"]
        let array7: [AnyObject] = ["网舞", "赵丽"] as [AnyObject]
        let array8: AnyObject = ["网舞", "赵丽"] as AnyObject
        
        

        let array9: [Any] = ["网舞", "赵丽"]
        let array10: Any = ["网舞", "赵丽"]
        let array11  = ["网舞", "赵丽"] as Any
        let array12  = ["网舞", "赵丽"] as [Any]
        let array13: [Any] = ["网舞", "赵丽"] as [Any]
        let array14: Any = ["网舞", "赵丽"] as Any

        print(array1)
        print(array2)
        print(array3)
        print(array4)
        print(array5)
        print(array6)
        print(array7)
        print(array8)
        print(array9)
        print(array10)
        print(array11)
        print(array12)
        print(array13)
        print(array14)
        
    }

    
    //MARK: 数组的合并
    func demo10() {
        var array = ["张三", "lisi"] as [Any]
        let array2 = ["网舞", "赵丽"] as [Any]
        
        let array3 = ["小李", 18] as [Any]
        
        // 目标 array2 合并到 array 中
        array += array2
        
        // 注意：在合并数组的时候，数组的类型必须保持一致
        array += array3
        
        print(array)
    }
    
    
    //MARK: 字典的合并
    func demo9() {
        
        var dict = ["name": "小花", "age": 18] as [String : Any]
        let dict2 = ["title": "老大", "name": "小芳"]
        
        // 将 dict2 的内容合并到 dict 中
        for (k, v) in dict2 {
            dict[k] = v
        }
        
        // 合并字典的时候，和设置内容一样，如果 key 有，覆盖，否则新增
        print(dict)
    }
    
    //MARK: 字典的基本操作 - 增/删/改
    func demo8() {
        /**
            let 是不可变
            var 是可变
        */
        
        var dict = ["name": "小花", "age": 18]  as [String : Any]
        
        // 如果 key 存在，值覆盖
        dict["name"] = "小草"
        
        // 如果 key 不存在，新增
        dict["title"] = "老大"
        
        print(dict)
        
        // 遍历
        /**
            k, v 是随便写的
        
            前面的是 key
            后面的是 value
        */
        for (key, value) in dict {
            print("KEY \(key) --- VALUES \(value)")
        }
    }
    
    //MARK: 字典
    func demo7() {
        /**
            OC 中定义字典使用 {}
            Swift 中仍然使用 []，是通过值对
        */
        // [String(key) : NSObject(value)]???
        let dict = ["name": "小花", "age": 18] as [String : Any]
        
        print(dict)
        
        // 提问：什么类型的字典使用最多？[String: AnyObject]
        // 因为从网络上获取的 JSON 有一个要求，KEY 必须是 NSString
        /**
        An object that may be converted to JSON must have the following properties:
        - Top level object is an NSArray or NSDictionary
            顶级节点必须是字典或者数组
        - All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
            所有的对象必须是 NSString, NSNumber, NSArray, NSDictionary, or NSNull
            如果是 数组 或者字典，内部同样只能包含 String, Number, NSNull
        - All dictionary keys are NSStrings
            所有的 key 必须都是 NSString
        - NSNumbers are not NaN or infinity
            NSNumber 不能为空或者无穷大
        
        在 JSON 中字符串有引号，Number 没有 引号，空值 null
        */
        
    }
    
    //MARK: 定义并且实例化一个空的存放字符串的数组
    func demo6() {
        // 定义并且实例化一个空的存放字符串的数组
        var array = [String]()
        
        array.append("张三")
        
        print(array)
    }
    
    //MARK: 测试数组容量
    func demo5() {
        // 定义一个存放字符串的数组，并没有分配空间
        var array: [String]
        
        // 分配空间
        array = [String]()
        
        for i in 0..<16 {
            array.append("张三 \(i)")
            
            // 当插入元素时，如果容量不够，会在当前容量基础上 * 2，方便后续的元素的增加
            print(array[i] + " - 容量 \(array.capacity)")
        }
        
        print(array)
    }
    
    //MARK: 数组的基本操作 - 增/删/改
    func demo4() {
        var array = ["zhangsan", "lisi"]
        
        // 增加
        array.append("wangwu")
        
        print(array)
        
        // 修改 － 通过下标获取元素，然后进行修改
        array[0] = "zhaoliu"
        print(array)
//
//        // 删除 － 删除第一个
        array.removeFirst()
        print(array)
//        // 删除最后一个
        array.removeLast()
        print(array)
//
//        // 删除所有元素，并且保留容量
        array.removeAll(keepingCapacity: true)
        print(array)
        print("数组容量 \(array.capacity)")
    }
    
    //MARK: 数组的基本操作 - 遍历
    func demo3() {
        let array = ["zhangsan", "lisi"]
        
        for s in array {
            print(s)
        }
    }
    
    //MARK: 数组的可变 NSMutableArray 和不可变 NSArray
    // 可变 var 不可变 let
    func demo2() {
        // 定义数组的时候，自动推导的类型是 [String]，决定数组中只能存放 String 类型
        // var array = ["zhangsan", "lisi"]
        // Swift 中有一个 `AnyObject`，表示任意对象
        // OC 中所有对象都继承自 NSObject
        // Swift 中的对象，可以没有任何父类
        var array = ["zhangsan", "lisi"]
        
        // 追加对象
        array.append("wangwu")
        // 不能直接追加数字，如果定义数组的时候，指定类型是 [NSObject]，就可以存放数字???好像变了
        //array.append(4)
    
        print(array)
    }

    //MARK: 数组
    func demo() {
        
        /**
            - 数组同样使用 []
            - 数字不需要包装成 NSNumber
            - 结构体同样需要包装成 NSValue
        */
        // [String] － 数组，是存放字符串的数组
         let array = ["zhangsan", "lisi"]
        print(array)
        // [NSObject] － 存放 NSObject 对象???好像变了
        // 提问：数组中存放相同类型的情况多！原因：数组是通过下标来遍历的！
        // 数组的准确类型，可以使用 option + click 判断
        let array2 = ["zhangsan", "lisi", 18, NSValue(cgPoint: CGPoint(x: 10, y: 10))] as [Any]
        
        print(array2)
    }
}

