//
//  main.m
//  id指针
//
//  Created by 翟佳阳 on 2021/8/9.
//

#import <Foundation/Foundation.h>
#import "Student.h"
int main(int argc, const char * argv[]) {
    NSObject* obj1 = [Person new];
    NSObject* obj2 = [Student new];
    [(Person*)obj1 sayHi];
    //强制类型转换
    id id1 = [Person new];
    [id1 sayHi];
    [id1 setName:@"jack"];
    Person* p1 = [Person person];
    Student* s1 = [Student person];
    //NSString* str = [Student person];会报错
    
    BOOL b1 = [Student respondsToSelector:@selector(person)];
    NSLog(@"b1 = %d",b1);
    
    BOOL b2 = [p1 isKindOfClass:[Person class]];
    NSLog(@"b2 = %d",b2);
    //判断p1对象是不是Person或Person子类对象
    
    BOOL b3 = [s1 isMemberOfClass:[Person class]];
    NSLog(@"b3 = %d",b3);
    //判断s1对象是不是Person类的对象，不包括其子类对象
    
    
    BOOL b4 = [Student isSubclassOfClass:[Person class]];
    NSLog(@"b4 = %d",b4);
    //判断Student是否是Person的子类
    
    
    return 0;
}
