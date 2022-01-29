//
//  MyAppInfo.m
//  异步下载网络图片
//
//  Created by 翟佳阳 on 2021/10/21.
//

#import "MyAppInfo.h"

@implementation MyAppInfo
+(instancetype)appInfoWithDict:(NSDictionary *)dict{
    MyAppInfo *appInfo = [[self alloc] init];
    [appInfo setValuesForKeysWithDictionary:dict];
    return appInfo;
}

+ (NSArray *)appInfos{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    //直接确定数组容量
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
    //遍历数组另外方式
    //使用blcok 采用枚举的方式遍历对象
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //字典转模型
        MyAppInfo *appInfo = [self appInfoWithDict:obj];
        [mArray addObject:appInfo];
    }];
    //可变数组copy变成不可变数组
    return mArray.copy;
}
@end
