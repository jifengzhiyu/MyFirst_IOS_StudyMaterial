//
//  ITCASTHelp.h
//  06网易彩票
//
//  Created by teacher on 15/7/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITCASTHelp : NSObject


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *html;
@property (nonatomic, copy) NSString *ID;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)helpWithDict:(NSDictionary *)dict;
@end
