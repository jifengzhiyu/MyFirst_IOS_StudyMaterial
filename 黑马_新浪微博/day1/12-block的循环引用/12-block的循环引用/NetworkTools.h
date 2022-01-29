//
//  NetworkTools.h
//  12-block的循环引用
//
//  Created by male on 15/10/11.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkTools : NSObject

- (void)loadData:(void (^)(NSString *html))finished;

@end
