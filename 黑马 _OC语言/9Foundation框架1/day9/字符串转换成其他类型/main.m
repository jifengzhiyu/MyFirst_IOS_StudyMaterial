//
//  main.m
//  字符串转换成其他类型
//
//  Created by 翟佳阳 on 2021/8/21.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    
    NSString * str3 = @"ABABAB";
    str3 = str3.lowercaseString;
    NSLog(@"%@",str3);
    
    
    NSString * str2 = @"zhale xuexiao qu";
    str2 = str2.uppercaseString;
    NSLog(@"%@",str2);
    
    
    NSString * str1 = @"     s  sd  ssd   ad  ";
    str1 = [str1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSLog(@"%@",str1);
    
    
    NSString * str = @"b2aa2aa21";
    int num = str.intValue;
    NSLog(@"%d",num+2);
    return 0;
}
