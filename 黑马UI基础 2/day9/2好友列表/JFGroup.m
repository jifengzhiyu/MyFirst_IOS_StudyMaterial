//
//  JFGroup.m
//  2好友列表
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import "JFGroup.h"
#import "JFFriend.h"
@implementation JFGroup
- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
        //把self.friends由字典模型转化成模型数据
        NSMutableArray *arrayModels = [NSMutableArray array];
        for(NSDictionary *dict_sub in self.friends){
            JFFriend * model = [JFFriend friendWithDict:dict_sub];
            [arrayModels addObject:model];
        }
        self.friends = arrayModels;
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
