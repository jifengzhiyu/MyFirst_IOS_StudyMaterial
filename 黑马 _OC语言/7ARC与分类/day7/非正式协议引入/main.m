//
//  main.m
//  非正式协议引入
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import "Person.h"
# import "NSObject+jifeng.h"
#import "NSString+jifeng.h"
int main(int argc, const char * argv[]) {
    Person * p1 = [Person new];
    [p1 run];
    
    NSString * str = @"阿2344kj0535妈6456吗765";
    [str run];//所有的OC对象都有run方法
    
    unichar ch = [str characterAtIndex:1];
    //按照下标，取出NSString里面的字符
    NSLog(@"ch = %C",ch);
    //按道理%C就可以，但是不知道为什么不可以
    
    
//    //找出字符串中阿拉伯数字的个数
//    int count = 0;
//    for(int i = 0; i < str.length; i++)
//    {
//        unichar ch0 = [str characterAtIndex:i];
//        if(ch0 >= '0' && ch0 <= '9')
//        {
//            count++;
//        }
//    }
//    NSLog(@"count = %d",count);
    
    int count = [str numberCount];
    NSLog(@"count = %d",count);
    return 0;
}
