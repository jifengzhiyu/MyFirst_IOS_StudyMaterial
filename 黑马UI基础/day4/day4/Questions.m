//
//  Questions.m
//  day4
//
//  Created by 翟佳阳 on 2021/9/4.
//

#import "Questions.h"

@implementation Questions
-(instancetype)initWithDict:(NSDictionary*)dict
{
    if(self = [super init])
    {
        self.answer = dict[@"answer"];
        self.icon = dict[@"icon"];
        self.options = dict[@"options"];
        self.title = dict[@"title"];
    }
    return self;
}
+(instancetype)questionWithDict:(NSDictionary*)dict{
    return  [[self alloc] initWithDict:dict] ;
}
@end
