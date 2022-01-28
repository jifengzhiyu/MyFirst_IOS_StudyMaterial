//
//  main.m
//  NSMutableString
//
//  Created by 翟佳阳 on 2021/8/21.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    
    NSArray
    
    Person * p1 = [Person new];
    NSString * s1 = @"酸菜鱼";
    NSMutableString *str1 = [NSMutableString string];
    [str1 appendString:@"烤肉"];
    [p1 eat:str1];
    
    
    //NSMutableString * str1 = @"jack";
    NSMutableString * str = [NSMutableString string];
    int num = 10;
    [str appendString:@"jack"];
    [str appendString:@"rose"];
    [str appendFormat:@"年龄%d",num];
    NSLog(@"%@",str);
    return 0;
}
