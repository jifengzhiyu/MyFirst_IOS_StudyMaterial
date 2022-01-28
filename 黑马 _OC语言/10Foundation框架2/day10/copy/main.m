//
//  main.m
//  copy
//
//  Created by 翟佳阳 on 2021/8/25.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    
//    NSString * str1 = @"helen";
//    NSString * str2 = [str1 copy];
//    str1 = @"12121";
//
//    NSLog(@"%@",str1);
//    NSLog(@"%@",str2);
    
    
    
    Person * p1 = [Person new];
    NSMutableString * str = [NSMutableString stringWithFormat:@"jack"];
    p1.name = str;
    [str appendString:@"12121"];
    NSLog(@"p1.name = %@",p1.name);
    
    
    
    
//    Person * p1 = [Person new];
//    NSString * str = @"jack";
//    p1.name = str;
//    str = @"rose";
//    NSLog(@"p1.name = %@",p1.name);
    
    
//    NSString * str1 = @"helen";
//    NSString * str2 = [str1 copy];
    
//    NSMutableString * str1 = [NSMutableString stringWithFormat:@"jack"];
//    NSMutableString * str2 = [str1 copy];
//    //[str2 appendString:@"aa"];
    
//    NSString * str1 = @"jack";
//    NSMutableString * str2 = [str1 mutableCopy];
//    [str2 appendString:@"1111"];
    
//    NSString * str1 = [NSString stringWithFormat:@"helen"];
//    NSLog(@"%lu",str1.retainCount);
//    NSString * str2 = [str1 copy];
//    NSLog(@"%lu",str1.retainCount);

    
//    NSMutableString * str2 = [str1 mutableCopy];
//    [str2 appendString:@"222"];
    
//    NSLog(@"%@",str1);
//    NSLog(@"%@",str2);
//    NSLog(@"%p",str1);
//    NSLog(@"%p",str2);

    return 0;
}
