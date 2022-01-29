//
//  main.m
//  day2
//
//  Created by 翟佳阳 on 2021/8/3.
//

#import <Foundation/Foundation.h>

@interface Phone : NSObject{
    @public
    NSString* _color;
    float _size;
    NSString* _cpu;
}
- (void)aboutMyPhone;
- (void)callWithNumber:(NSString*)number;
- (void)sendWithMessage:(NSString*)msg toNumber:(NSString*)number;
//to很想自然语言了
@end

@implementation Phone
- (void)aboutMyPhone{
    NSLog(@"颜色：%@ 大小：%f CUP型号：%@",_color,_size,_cpu);
}
- (void)callWithNumber:(NSString*)number{
    NSLog(@"正在呼叫%@",number);
}
- (void)sendWithMessage:(NSString*)msg toNumber:(NSString*)number{
    NSLog(@"正在向%@发射信息:%@",number,msg);
}
@end

int main(int argc, const char * argv[]) {
    Phone* iPhone = [Phone new];
    iPhone->_color = @"白";
    iPhone->_cpu = @"最新";
    iPhone->_size = 9.9f;
    [iPhone aboutMyPhone];
    [iPhone callWithNumber:@"120"];
    [iPhone sendWithMessage:@"娃的脑袋又卡栏杆了" toNumber:@"120"];
    return 0;
}
