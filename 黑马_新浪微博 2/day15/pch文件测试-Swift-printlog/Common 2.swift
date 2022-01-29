//
//  Common.swift
//  pch文件测试-Swift-printlog
//
//  Created by 翟佳阳 on 2021/12/24.
//

import Foundation

func printLogDebug<T>(message: T,
                      file: String = #file,
                      method: String = #function,
                      line: Int = #line)
{
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}
