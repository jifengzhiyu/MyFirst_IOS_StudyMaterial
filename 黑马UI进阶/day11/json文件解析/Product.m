//
//  Product.m
//  json文件解析
//
//  Created by 翟佳阳 on 2021/10/15.
//

#import "Product.h"

@implementation Product
/*
 "title": "邮箱大师",
 "stitle":"网易推出的通用邮箱APP",
 "id": "com.netease.mailmaster",
 "url": "https://itunes.apple.com/cn/app/you-xiang-da-shi/id897003024?mt=8",
 "icon": "mail",
 "customUrl": "mailmaster"
 */

//字典转模型
+ (instancetype)productWithDict:(NSDictionary *)dict{
    
    Product *p = [[self alloc] init];
    p.title = dict[@"title"];
    
    p.stitle = dict[@"stitle"];

    p.ids = dict[@"ids"];

    p.url = dict[@"url"];

    p.icon = dict[@"icon"];

    p.customUrl = dict[@"customUrl"];
    
    return p;

}

@end
