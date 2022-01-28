//
//  main.m
//  day3
//
//  Created by 翟佳阳 on 2021/9/30.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        //沙盒目录
        ///Users/kaixin/Library/Developer/CoreSimulator/Devices/DBC944B2-0096-4146-A2D0-6F2990F73545/data/Containers/Data/Application/C0354447-D193-43E5-82CB-FCA974FEE086
        NSLog(@"%@",NSHomeDirectory());
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
