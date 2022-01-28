//
//  main.m
//  NSString
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    NSString* str = @"jack";
    NSLog(@"str = %p",str);
    NSLog(@"str = %@",str);

    char* str0 = "rose";
    NSString* str1 = [NSString stringWithUTF8String:str0];
    NSLog(@"%@",str1);

    int age = 10;
    NSString* name = @"小米";
    NSString* str2 = [NSString stringWithFormat:@"大家好，我叫%@，今年%d岁了",name,age];
    NSLog(@"str = %@",str2);

    NSString* str3 = @"爱你啊";
    NSUInteger len = [str3 length];
    NSLog(@"len = %lu",len);
    //typedef unsigned long NSUInteger;
    //%lu表示输出无符号长整型整数(long unsigned)
    
    NSString* str4 = @"ahaha";
    unichar ch = [str4 characterAtIndex:2];
    //unsigned short unichar
    NSLog(@"ch = %c",ch);
    //其实unichar应该是%C输出，但好像变了，先不管了
    
    NSString* str5 = @"helen";
    NSString* str6 = @"helen";
    BOOL bbool = [str5 isEqualToString:str6];
    NSLog(@"%@",bbool ? @"YES":@"NO");
    
    NSString* str7 = @"nihao";
    NSString* str8 = @"hongbuhong";
    NSComparisonResult res = [str7 compare:str8];
    NSLog(@"res = %d",res);
    return 0;
}
