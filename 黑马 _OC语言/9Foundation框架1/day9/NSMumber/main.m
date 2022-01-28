//
//  main.m
//  NSMumber
//
//  Created by 翟佳阳 on 2021/8/22.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
//    NSNumber * number1 = @10;
//    NSNumber * number2 = @20;
//    NSNumber * number3 = @30;
    
    Person * p1 = [Person numberWithIntValue:100];
    Person * p2 = [Person numberWithIntValue:200];
    Person * p3 = [Person numberWithIntValue:300];
    NSArray * arr3 = @[p1,p2,p3];
    Person * p0 = arr3[1];//arr数组元素的类型是Person
    NSLog(@"%d",p0.intValue);

    
    NSArray * arr = @[@10,@20,@30];
    int num0 = 50;
    NSNumber * num1 = @(num0);
    for(NSNumber *num in arr)
    {
        NSLog(@"%f",num.floatValue);
    }
    
    return 0;
}
