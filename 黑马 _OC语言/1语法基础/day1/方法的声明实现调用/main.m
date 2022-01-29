//
//  main.m
//  方法的声明实现调用
//
//  Created by 翟佳阳 on 2021/8/2.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString*_name;
    int _age;
}
- (void) run;
- (void) eatWith: (NSString*)foodName;
- (int) sumWithNum1: (int)num1 andNum2: (int)num2;
@end

@implementation Person
- (void) run
{
    //方法实现的代码
    NSLog(@"试一哈");
}
- (void) eatWith: (NSString*)foodName
{
    NSLog(@"好想吃%@",foodName);
}
- (int) sumWithNum1: (int)num1 andNum2: (int)num2
{
    int num3 = num1 + num2;
    return num3;
}
@end



int main(int argc, const char * argv[]) {
    Person* p1 = [Person new];
    [p1 run];
    [p1 eatWith:@"酸菜鱼"];
    int sum = [p1 sumWithNum1 :10 andNum2:20];
    NSLog(@"sum = %d",sum);
    return 0;
}
