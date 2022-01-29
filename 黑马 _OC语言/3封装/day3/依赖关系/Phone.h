//
//  Phone.h
//  依赖关系
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Phone : NSObject
{
    NSString* _brand;
    int _price;
}

- (void)callWithNumber:(NSString*)number;

@end

NS_ASSUME_NONNULL_END
