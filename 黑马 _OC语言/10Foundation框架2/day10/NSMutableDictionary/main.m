//
//  main.m
//  NSMutableDictionary
//
//  Created by 翟佳阳 on 2021/8/23.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    
    NSDictionary * dict1 = [NSDictionary dictionaryWithContentsOfFile:@"/Users/kaixin/Documents/pl.plist"];
    NSLog(@"%@",dict1);
//    NSMutableDictionary * dict1 = [NSMutableDictionary new];
//    [dict1 setObject:@"火星" forKey:@"xingqiu"];
//    [dict1 setObject:@"jack" forKey:@"name"];
//    [dict1 setObject:@"helen" forKey:@"name"];
//    [dict1 removeObjectForKey:@"xingqiu"];
    //[dict1 writeToFile:@"/Users/kaixin/Documents/pl.plist" atomically:NO];
//    [dict1 removeAllObjects];

    
//    NSMutableDictionary * dict2 = [[NSMutableDictionary alloc] init];
//    NSMutableDictionary * dict3 = [NSMutableDictionary dictionary];
    return 0;
}
