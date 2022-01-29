//
//  main.m
//  NSDictionary
//
//  Created by 翟佳阳 on 2021/8/23.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    
    Person * p1 = [[Person alloc]initWithName:@"小米1"];
    Person * p2 = [[Person alloc]initWithName:@"小米2"];
    Person * p3 = [[Person alloc]initWithName:@"小米3"];
    Person * p4 = [[Person alloc]initWithName:@"小米4"];
    NSArray * arr0 = @[p1,p2,p3,p4];
    NSDictionary * dict0 = @{
        p1.name:p1,
        p2.name:p2,
        p3.name:p3
    };
    dict0 [@"小米1"];

    
    NSDictionary * dict = @{@"name":@"rose",@"l语言":@"1OC",@"2星球":@"2火星"};
    NSLog(@"%@",dict);
    NSLog(@"===================");
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@ %@",key,obj);
    }];
    
    
    NSString * str = [dict objectForKey:@"name"];
    NSLog(@"%lu",dict.count);
//    for(id item in dict)
//    {
//        NSLog(@"%@ = %@",item,dict[item]);
//    }
    
//    NSLog(@"%@",[dict objectForKey:@"name"]);

    
//    NSLog(@"%@",dict[@"name"]);
    
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"jack",@"name",@"OC",@"lan" ,nil];
    
    return 0;
}
