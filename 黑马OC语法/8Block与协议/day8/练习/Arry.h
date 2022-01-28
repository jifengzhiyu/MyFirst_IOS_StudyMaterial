//
//  Arry.h
//  练习
//
//  Created by 翟佳阳 on 2021/8/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef BOOL (^NewType)(char * country1,char * cuontry2);
@interface Arry : NSObject
//- (void)sortWithCountries:(char *[])countries andLength:(int)len;
- (void)sortWithCountries:(char*[_Nullable])countries andLenth:(int)len andCompareBlock:(NewType)compareBlock;
@end

NS_ASSUME_NONNULL_END
