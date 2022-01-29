//
//  QuanQuan.h
//  对象作为类的属性
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuanQuan : NSObject
{
    @public
    NSString* _color;
    float _size;
}

- (void)bLingBLing;
@end

NS_ASSUME_NONNULL_END
