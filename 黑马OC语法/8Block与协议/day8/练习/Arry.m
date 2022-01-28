//
//  Arry.m
//  练习
//
//  Created by 翟佳阳 on 2021/8/17.
//

#import "Arry.h"
#import "string.h"
@implementation Arry
- (void)sortWithCountries:(char*[])countries andLenth:(int)len andCompareBlock:(NewType)compareBlock{
    


//- (void)sortWithCountries:(char *[])countries andLength:(int)len{
    
    for(int i = 0; i < len - 1; i++)
    {
        for(int j = 0; j < len -1 -i; j++){
//    int res = strcmp(countries[j], countries[j+1]);
            BOOL res = compareBlock(countries[j], countries[j+1]);
    if(res == YES)
    {
        char* temp = countries[j];
        countries[j] = countries[j+1];
        countries[j+1] = temp;
    }
}
}
}

@end
