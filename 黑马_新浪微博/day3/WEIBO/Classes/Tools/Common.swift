//
//  Common.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/11/25.
//

import UIKit

// MARK: - 全局通知定义
//通知--》一对多 代理--〉一对一
/// 切换根视图控制器通知 － 一定要够长，要有前缀
let WBSwitchRootViewControllerNotification = "WBSwitchRootViewControllerNotification"
/// 选中照片通知
let WBStatusSelectedPhotoNotification = "WBStatusSelectedPhotoNotification"
/// 选中照片的 KEY - IndexPath
let WBStatusSelectedPhotoIndexPathKey = "WBStatusSelectedPhotoIndexPathKey"
/// 选中照片的 KEY - URL 数组
let WBStatusSelectedPhotoURLsKey = "WBStatusSelectedPhotoURLsKey"


// 目的：提供全局共享属性或者方法，类似于 pch 文件
/// 全局外观渲染颜色 -> 延展出`配色`的管理类
let WBAppearanceTintColor = UIColor.orange

// MARK: - 全局函数，可以直接使用
/// 延迟在主线程执行函数
///
/// - parameter delta:    延迟时间
/// - parameter callFunc: 要执行的闭包
func delay(delta: Double, callFunc: @escaping ()->()) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delta) {
        callFunc()
    }
    
}

