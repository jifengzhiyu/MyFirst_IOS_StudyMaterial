//
//  Group.m
//  汽车右侧索引
//
//  Created by 翟佳阳 on 2021/9/13.
//

#import "Group.h"
#import "Car.h"
@implementation Group
//当有模型嵌套的时候需要手动把字典转化成模型
-(instancetype)initWithDict:(NSDictionary*)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
        //等价于
//        self.title = dict[@"title"];
//        self.cars = dict[@"cars"];但是这个没用
        //因为没有变成模型，还是字典数组
        
        //创建一个用来保存模型的数组
        NSMutableArray * arrayModels = [NSMutableArray array];
        //手动遍历将字典转化为模型
        for (NSDictionary * item_dict in dict[@"cars"]) {
            Car * model = [Car carWithDict:item_dict];
            [arrayModels addObject:model];
        }
        self.cars = arrayModels;
    }
    return self;
}
+(instancetype)groupWithDict:(NSDictionary*)dict{
    return [[self alloc]initWithDict:dict];
}
@end
