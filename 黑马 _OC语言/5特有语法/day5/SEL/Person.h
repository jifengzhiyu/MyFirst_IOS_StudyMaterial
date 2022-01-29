//
//  Person.h
//  SEL
//
//  Created by 翟佳阳 on 2021/8/8.
//

#import <Foundation/Foundation.h>
#import "Wine.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
- (void)sayHi;
- (void)eatfood:(NSString*)food;
-(void)drinkWithWine:(NSString*)hongJiu:(NSString*)Weishiji:(NSString*)LongSheLan:(NSString*)WeiShiJi;
@end

NS_ASSUME_NONNULL_END
