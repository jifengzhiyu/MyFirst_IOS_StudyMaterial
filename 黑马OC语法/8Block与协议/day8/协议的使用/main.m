//
//  main.m
//  协议的使用
//
//  Created by 翟佳阳 on 2021/8/18.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    Person * p1 = [Person new];
    [p1 playLOL];
    [p1 paShan];
    [p1 chifan];
    [p1 hetang];
    
    // cannot find declaration => spelling
    return 0;
}
