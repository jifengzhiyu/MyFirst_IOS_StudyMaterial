//
//  main.m
//  NSArray数组的遍历
//
//  Created by 翟佳阳 on 2021/8/22.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    NSString * str1 = @"啊哈哈#吧啊吧#哦哦";
    NSArray * arr3 = [str1 componentsSeparatedByString:@"#"];
    for(NSString * item1 in arr3)
    {
        NSLog(@"%@",item1);
    }
    
    
    NSArray * arr2 = @[@"jack",@"rose",@"helen"];
    NSString * str = [arr2 componentsJoinedByString:@"$"];
    NSLog(@"%@",str);
    
    [arr2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
        NSLog(@"idx = %lu",idx);
        if(idx == 1)
        {
            * stop = YES;
        }
    }];
    
    Person * p1 = [Person new];
    Person * p2 = [Person new];
    Person * p3 = [Person new];
    Person * p4 = [Person new];
    NSArray* arr1 = @[p1,p2,p3,p4,@"aaaa"];
    for(id item in arr1)
    {
        NSLog(@"%@",item);
    }
    
    
    NSArray * arr = @[@"jack",@"rose",@"helen"];
    for(NSString *str in arr)
    {
        NSLog(@"%@",str);
    }
    
//    for(int i = 0; i < arr.count; i++)
//    {
//        //NSLog(@"%@",arr[i]);
//        NSLog(@"%@",[arr objectAtIndex:i]);
//    }
    return 0;
    
}
