//
//  main.m
//  练习
//
//  Created by 翟佳阳 on 2021/8/17.
//

#import <Foundation/Foundation.h>
#import "Arry.h"
#import "string.h"
int main(int argc, const char * argv[]) {
    char * countries[] =
    {
        "Asdadas",
        "Cf",
        "Btyut"
    };
    Arry * arr = [Arry new];
//    [arr sortWithCountries:countries andLength:sizeof(countries)/8];
    
    [arr sortWithCountries:countries andLenth:sizeof(countries)/8 andCompareBlock:^BOOL(char * _Nonnull country1, char * _Nonnull country2) {
        
        int res = (int)strlen(country1) - (int)strlen(country2);
        if(res > 0)
        {
            return YES;
        }
            return NO;
    }];
    //按照字符个数排序
    for(int i = 0;i < sizeof(countries)/8; i++)
    {
        NSLog(@"%s",countries[i]);
    }
    
    NSLog(@"-------------");
    
    [arr sortWithCountries:countries andLenth:sizeof(countries)/8 andCompareBlock:^BOOL(char * _Nonnull country1, char * _Nonnull country2) {
        
        int res0 = strcmp(country1, country2);
        if(res0 > 0)
        {
            return YES;
        }
            return NO;
    }];
    //按照字母排序
    for(int i = 0;i < sizeof(countries)/8; i++)
    {
        NSLog(@"%s",countries[i]);
    }
    return 0;
}
