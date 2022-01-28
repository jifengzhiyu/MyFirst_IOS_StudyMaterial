//
//  main.m
//  NSArray
//
//  Created by 翟佳阳 on 2021/8/21.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    NSArray * arr3 = @[];
    NSLog(@"%@",arr3.firstObject);
    
   
    
    
    NSArray * arr1 = @[@"11111",@"33333",@"22222",@"33333"];
    NSUInteger index = [arr1 indexOfObject:@"333"];
    
    NSLog(@"%lu",index);
    NSLog(@"%@",arr1.lastObject);
    
    
    
    BOOL res = [arr1 containsObject:@"cc"];
    NSLog(@"%d",res);
    
    NSLog(@"arr1.count = %lu",arr1.count);
    
    //NSString * str = [arr1 objectAtIndex:1];
    //NSLog(@"%@",str);
    
//    NSLog(@"%@",arr1[0]);
//    NSLog(@"%@",arr1[1]);
    //NSLog(@"%@",arr1[9]);
    
    Person * p2 = [Person new];
    //Person * p3 = nil;
    Person * p4 = [Person new];
    Person * p5 = [Person new];
    
    NSArray * arr2 = @[p2,p5,p4];
    NSLog(@"%@",arr2);

   // NSArray * arr = [NSArray arrayWithObjects:@"jack", @"rose",p5,p2,p3,p4,nil, @"helen", nil];
    //NSLog(@"%@",arr);
    
    
    return 0;
}
