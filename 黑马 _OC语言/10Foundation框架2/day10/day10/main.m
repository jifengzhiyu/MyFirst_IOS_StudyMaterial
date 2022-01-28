//
//  main.m
//  day10
//
//  Created by 翟佳阳 on 2021/8/22.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    
    
    NSMutableArray * arr0 = [NSMutableArray arrayWithObjects:@"jack",@"rose", nil];
    [arr0 addObject: @"helen"];
    [arr0 removeObjectAtIndex:0];
    [arr0 removeObjectAtIndex:1];

    
    NSArray * arr = [NSArray arrayWithContentsOfFile:@"/Users/kaixin/Documents/p2.plist"];
    if(arr != nil)
    {
        for(NSString * str in arr)
        {
            NSLog(@"%@",str);
        }
    }
    
//    NSArray * arr = @[@"jack",@"rose",@"helen"];
//    [arr writeToFile:@"/Users/kaixin/Documents/pl.plist" atomically:NO];
  return 0;
}
