//
//  main.m
//  static
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
int main(int argc, const char * argv[]) {
//    Person* p1 = [Person new];
//    [p1 sayHi];
//    [p1 sayHi];
//    [p1 sayHi];
    
    Student *s1 = [Student studentWithName:@"jack1" andAge:20];
    Student *s2 = [Student studentWithName:@"jack2" andAge:20];
    Student *s3 = [Student studentWithName:@"jack3" andAge:20];
    Student *s4 = [Student studentWithName:@"jack4" andAge:20];
    return 0;
}
