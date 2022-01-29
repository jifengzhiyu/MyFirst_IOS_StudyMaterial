//
//  main.m
//  继承注意
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Teacher.h"
int main(int argc, const char * argv[]) {
    Person* p1 = [Person new];
    [p1 setName:@"杰克"];
    [p1 setAge:20];
    [p1 setHeight:189.3f];
    [p1 setWeight:60.2f];
    
    Teacher* t1 = [Teacher new];
    [t1 sayHiPerson];
    [t1 sayHiStudent];
    [t1 sayHiTeacher];
    
    return 0;
}
