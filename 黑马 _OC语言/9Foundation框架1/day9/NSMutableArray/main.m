//
//  main.m
//  NSMutableArray
//
//  Created by 翟佳阳 on 2021/8/22.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    NSMutableArray * arr1 = [NSMutableArray new];
    NSMutableArray * arr2 = [[NSMutableArray alloc]init ];
    NSMutableArray * arr3 = [NSMutableArray array];
    NSMutableArray * arr4 = [NSMutableArray arrayWithObjects:@"jack",@"rose",@"ababba",@"rose", nil];
    [arr4 removeAllObjects];
    NSLog(@"%@",arr4);

    
    [arr4 removeLastObject];

    
    
    
    NSMutableArray * arr5 = [NSMutableArray arrayWithObjects:@"aaa",@"aa1",@"aaa",@"aaa",@"aaa",@"aaa",@"aaa2", nil];
    [arr5 removeObject:@"aaa" inRange:NSMakeRange(2,3)];
   // NSLog(@"%@",arr5);

    
    [arr4 removeObject:@"rose"];

    
//    [arr4 removeObjectAtIndex:1];

    
    //[arr4 insertObject:@"hahah" atIndex:2];
    
    [arr4 addObject:@"1212"];
    //NSArray * arr5 = @[@"aaaa",@"bbbb",@"ccccc"];
//    [arr4 addObject:arr5];
    [arr4 addObjectsFromArray:arr5];
    NSLog(@"%lu",arr4.count);
    NSLog(@"%@",arr4);
    
   // NSMutableArray * arr5 = @[@"11",@"22",@"33"];
    return 0;
}
