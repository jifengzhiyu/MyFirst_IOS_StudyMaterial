//
//  Product.h
//  json文件解析
//
//  Created by 翟佳阳 on 2021/10/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Product : NSObject
/*
 "title": "邮箱大师",
 "stitle":"网易推出的通用邮箱APP",
 "id": "com.netease.mailmaster",
 "url": "https://itunes.apple.com/cn/app/you-xiang-da-shi/id897003024?mt=8",
 "icon": "mail",
 "customUrl": "mailmaster"
 */

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * stitle;

@property (nonatomic, copy) NSString * ids;

@property (nonatomic, copy) NSString * url;

@property (nonatomic, copy) NSString * icon;

@property (nonatomic, copy) NSString * customUrl;


+ (instancetype)productWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
