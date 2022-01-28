//
//  main.m
//  常用结构体
//
//  Created by 翟佳阳 on 2021/8/24.
//

#import <Foundation/Foundation.h>
#import "View.h"
int main(int argc, const char * argv[]) {
    
    CGPoint p1 = CGPointMake(10, 20);
    CGPoint p2 = CGPointMake(30, 40);
    CGPoint p3 = CGPointMake(50, 60);
//声明初始化
    NSValue * v1 = [NSValue valueWithPoint:p1];
    NSValue * v2 = [NSValue valueWithPoint:p2];
    NSValue * v3 = [NSValue valueWithPoint:p3];
//+ (NSValue *)valueWithPoint:(NSPoint)point;
    NSArray * arr = @[v1,v2,v3];
    for(NSValue * v in arr)
    {
        NSLog(@"%@",NSStringFromPoint(v.pointValue));
    }
//NSString * NSStringFromPoint(NSPoint aPoint);
//Returns a string representation of a point.
//将CGPoint转化成NSString
    
//@property (readonly) NSPoint pointValue;
//拿到NSValue里面的CGPoint
    
    
//    CGRect rect1 = CGRectMake(10, 20, 30, 40);
//    CGRect rect2 = NSMakeRect(10, 20, 30, 40);
    
    
//    CGRect rect;
//    rect.origin = (CGPoint){10,20};
//       rect.size = (CGSize){30,40};
//
//
////    rect.origin.x = 10;
////    rect.origin.y = 20;
////    rect.size.width = 30;
//    rect.size.height = 40;
    
    
    View * view1 = [[View alloc] init];
    view1.point = CGPointMake(0, 0);
    view1.size = CGSizeMake(1920, 1080);
    
    Button * btn = [[Button alloc] init];
    btn.point = CGPointMake(100, 100);
    btn.size = CGSizeMake(100, 20);
    btn.text = @"注册";
    
    [view1.subViews addObject:btn];
    
    Button * btn1 = [[Button alloc] init];
    btn.point = CGPointMake(200, 200);
    btn.size = CGSizeMake(200, 20);
    btn.text = @"哈哈";
    
    [view1.subViews addObject:btn1];
    
//    CGSize size1;
//    size1.width = 10;
//    size1.height = 20;
//    //1
//    CGSize size2 = {10,20};
//    //2
//    CGSize size3 = {.width = 10, .height = 20};
//    //3
//    CGSize size4 = CGSizeMake(10, 20);
//    //4
//    CGSize size5 = NSMakeSize(10, 20);
    
    
//    CGPoint p1;
//    p1.x = 10;
//    p1.y = 20;
//    //1
//    CGPoint p2 = {10,20};
//    //2
//    CGPoint p3 = {.x = 10, .y = 20};
//    //3
//    //CGPoint p4 = CGPointMake(10, 20);
//    CGPoint p4 = NSMakePoint(10, 20);
//    NSLog(@"p.x = %lf, p.y = %lf",p4.x,p4.y);
    return 0;
}
