//
//  main.m
//  字符串的搜索
//
//  Created by 翟佳阳 on 2021/8/21.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    
    NSString * str2 = @"希腊我爱希腊吗？";
    str2 = [str2 stringByReplacingOccurrencesOfString:@"希腊" withString:@"日本"];
    NSLog(@"%@",str2);
    
    
    NSString * str0 = @"我不想去学校";
    //NSString * newStr = [str0 substringFromIndex:3];
    //NSString * newStr = [str0 substringToIndex:3];
    NSString * newStr = [str0 substringWithRange:NSMakeRange(2, 3)];

    NSLog(@"%@",newStr);
    
    NSRange ran = NSMakeRange(1, 9);
    NSLog(@"%@",NSStringFromRange(ran));
    
    NSString * str = @"wo bu xue xiang kai xue";
    //NSRange range = [str rangeOfString:@"xue"];
    NSRange range = [str rangeOfString:@"kai" options:NSBackwardsSearch];
    NSLog(@"location = %lu",range.location);
    NSLog(@"lenth = %lu",range.length);
    
    if(range.length == 0)
    {
        NSLog(@"没找到");
    }else
    {
        NSLog(@"找到了");
    }
    
    if(range.location == NSNotFound)
    {
        NSLog(@"没找到");
    }else
    {
        NSLog(@"找到了");
    }
    return 0;
}
