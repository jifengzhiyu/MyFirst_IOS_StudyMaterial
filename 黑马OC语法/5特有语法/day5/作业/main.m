//
//  main.m
//  作业
//
//  Created by 翟佳阳 on 2021/8/7.
//

#import <Foundation/Foundation.h>
#import "Student.h"
/*
 1、人类：
 姓名，性别，年龄
 2、书类：
 书名，作者，出版社，出版日期
 3、学生类：
 姓名 性别 年龄 学号 书
 方法：读书
 */
int main(int argc, const char * argv[]) {
    Author* a1 = [Author new];
    [a1 setName:@"洛娃"];
    [a1 setAge:20];
    [a1 setGender:GenderFemale];
    
    Book* b1 = [Book new];
    [b1 setName:@"永远停不下来的战争"];
    [b1 setPublishDate:(Date){2021,8,7}];
    [b1 setPublisherName:@"家庭问题调查局"];
    [b1 setAuthor:a1];
    
    Student* s1 = [Student new];
    [s1 setName:@"一个娃"];
    [s1 setAge:10];
    [s1 setGender:GenderMale];
    [s1 setBook:b1];
    return 0;
}
