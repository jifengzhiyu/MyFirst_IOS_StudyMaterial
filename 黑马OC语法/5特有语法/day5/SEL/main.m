//
//  main.m
//  SEL
//
//  Created by 翟佳阳 on 2021/8/8.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Wine.h"
int main(int argc, const char * argv[]) {
    Person* p1 = [Person new];
    SEL s1 = @selector(sayHi);
    //typedef struct objc_selector *SEL;
    //SEL是typedef类型，在自定义加了*，再次声明就不需要加*
    NSLog(@"s1 = %p",s1);
    //将SEL消息发送给p1对象
    [p1 performSelector:s1];
    //实质是调用sayHi方法
    
    SEL s2 = @selector(eatfood:);
    [p1 performSelector:s2 withObject:@"牛蛙"];
    
    Wine* w1 = [Wine new];
    w1 -> _LongSheLan = @"龙舌兰";
    w1 -> _Weishiji = @"威士忌";
    w1 -> _hongJiu = @"红酒";
    w1 -> _JinJiu = @"金酒";
    SEL s3 = @selector(drinkWithWine:);
    [p1 performSelector:s3 withObject:w1];
      
    return 0;
}
