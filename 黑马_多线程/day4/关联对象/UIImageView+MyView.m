//
//  UIImageView+MyView.m
//  关联对象
//
//  Created by 翟佳阳 on 2021/10/26.
//

#import "UIImageView+MyView.h"
//在运行期间给某个对象增加属性（一般在属性在运行前编译
//在运行期间获取某个对象的所有属性
//交换方法
#import <objc/runtime.h>

@implementation UIImageView (MyView)
- (NSString *)urlString{
    return objc_getAssociatedObject(self, "str");
}

- (void)setUrlString:(NSString *)urlString
{
    ////在运行期间给某个对象增加属性（一般在属性在运行前编译
    //关联对象
    objc_setAssociatedObject(self, "str", urlString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
