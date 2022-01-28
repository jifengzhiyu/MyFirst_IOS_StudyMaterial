//
//  Person.m
//  依赖关系
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import "Person.h"

@implementation Person
- (void)callWithPhone:(Phone*)phone{
    [phone callWithNumber:@"110"];
}
@end
