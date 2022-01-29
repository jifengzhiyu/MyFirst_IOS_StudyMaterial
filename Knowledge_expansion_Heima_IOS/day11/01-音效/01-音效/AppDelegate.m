//
//  AppDelegate.m
//  01-音效
//
//  Created by dream on 15/12/23.
//  Copyright © 2015年 dream. All rights reserved.
//

#import "AppDelegate.h"
#import "HMAudioTools.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark 清空全局的音效文件
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [HMAudioTools clearMemory];
    NSLog(@"%s",__func__);
}

@end
