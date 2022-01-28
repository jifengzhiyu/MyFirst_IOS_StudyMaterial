//
//  main.m
//  自动释放池
//
//  Created by 翟佳阳 on 2021/8/13.
//

#import <Foundation/Foundation.h>
#import"Person.h"
int main(int argc, const char * argv[]) {
    Person * p1 = [Person new];
    @autoreleasepool {
        //Person* p1 = [[Person new] autorelease];
        //同理 Person* p1 = [[[Person alloc] init] autorelease];
        //将p1对象存储在当前的自动释放池
        
        [p1 autorelease];
     
       
    }
    NSLog(@"haha");
    return 0;
}

