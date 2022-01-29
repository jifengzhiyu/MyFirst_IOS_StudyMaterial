//
//  ViewController.m
//  03CoreData实战
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "ViewController.h"
#import "HMCoreDataManager.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //存储数据
    [self saveData];
    
    //查询数据
    [self fetchData];
}

//存储数据
- (void)saveData
{
    //通过实体描述描述出实体对象
  Person *person =  [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:[HMCoreDataManager sharedManager].managerContext];

    
    //数据存储插入操作  KVC
//    [person setValue:@"leo" forKey:@"name"];
    person.name = @"wwh11111";
    person.age = @(23);
    
    //通过上下文进行提交存储
    [[HMCoreDataManager sharedManager].managerContext save:nil];
    
}

//查询数据
- (void)fetchData
{
    
    //查询请求
    NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
    
    //设置一些参数
    //实体
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[HMCoreDataManager sharedManager].managerContext];
    //设置实体
    fetchrequest.entity = entity;
    
//    //谓词   有点像SQL语句中的 where
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"age = %@",@"26"];
//    //设置一下
//    fetchrequest.predicate = pre;
    
    //排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    //设置排序
    fetchrequest.sortDescriptors = @[sort];
    
    //执行查询请求
    NSArray *temp = [[HMCoreDataManager sharedManager].managerContext executeFetchRequest:fetchrequest error:nil];
    
    //打印结果集
    for (Person *person in temp) {
        NSLog(@"%@ 一共有多少个记录%lu",person.name,temp.count);
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
