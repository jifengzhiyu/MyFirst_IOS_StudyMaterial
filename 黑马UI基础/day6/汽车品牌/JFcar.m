//
//  JFcar.m
//  汽车品牌
//
//  Created by 翟佳阳 on 2021/9/11.
//

#import "JFcar.h"

@implementation JFcar
//必须要封装的两个方法
-(instancetype)initWithDict:(NSDictionary*)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
        //把键值对赋值给属性，前提条件是属姓名和键名一样
    }
    return self;
}

+(instancetype)carWithDict:(NSDictionary*)dict{
    return [[self alloc] initWithDict:dict];
}
@end
