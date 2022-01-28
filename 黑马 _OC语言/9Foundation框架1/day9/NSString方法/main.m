//
//  main.m
//  NSString方法
//
//  Created by 翟佳阳 on 2021/8/19.
//

#import <Foundation/Foundation.h>
#define LogBOOL(var) NSLog(@"%@",var == YES? @"YES" : @"NO")
int main(int argc, const char * argv[]) {
    
    NSURL *u2 = [NSURL URLWithString:@"file:///Users/kaixin/Documents/aaa.txt"];
    NSString * str3 = @"ccccccccccccccc";
BOOL res1 = [str3 writeToURL:u2 atomically:NO encoding:NSUTF8StringEncoding error:nil];
    
    
    NSURL * u1 = [NSURL URLWithString:@"file:///Users/kaixin/Documents/aaa.txt"];
    NSString * str2 = [NSString stringWithContentsOfURL:u1 encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",str2);

    NSString * str = @"学习";
    NSError * err;
    BOOL res = [str writeToFile:@"/Users/kaixin/" atomically:NO encoding: NSUTF8StringEncoding error:&err];
    
    if(res == YES)
    {
        NSLog(@"写入成功");
    }else
    {
        NSLog(@"失败");
    }
    
    if(err != nil)
    {
        NSLog(@"失败");
        NSLog(@"%@",err.localizedDescription);
        //打印出错原因
        //NSLog(@"%@",err);
    }else
    {
        NSLog(@"写入成功");
    }
    
    NSError *err0;
    NSString * str0 = [NSString stringWithContentsOfFile:@"/Users/kaixin/Documents/aaa.txt" encoding:NSUTF8StringEncoding error:&err0];
    if(err != nil)
    {
        NSLog(@"%@",err0);
    }else
    {
        NSLog(@"%@",str);
    }
//    NSString * str = @"jack";
//    const char * s = str.UTF8String;
//    NSLog(@"%s",s);
    
    
//    char * str = "jack";
//    NSString * str1 = [NSString stringWithUTF8String:str];
//    NSLog(@"%@",str1);
    
    
//    NSString * str1 = @"jack";
////    NSString * str2 = @"jack";
//    NSString * str2 = [NSString stringWithFormat:@"jack"];
//    //BOOL res = str1 == str2;
//    BOOL res = [str1 isEqual:str2];
//    LogBOOL(res);
    
//    int age = 10;
//    NSString * name = @"小米";
//    NSString * str = [NSString stringWithFormat:@"我是%@,今年%d",name,age];
////    NSLog(@"%@",str);
//
//    NSUInteger len = str.length;
//    NSLog(@"%lu",len);
    
//    NSString * str = @"jack";
//    unichar ch = [str characterAtIndex:2];
//    NSLog(@"ch = %C",ch);
    //按道理来说%C先不管了
    
    
    
    return 0;
}
