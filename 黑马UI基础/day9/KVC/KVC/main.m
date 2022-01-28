//
//  main.m
//  KVC
//
//  Created by 翟佳阳 on 2021/9/21.
//

#import <Foundation/Foundation.h>
#import "Dog.h"
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //直接为对象的属性赋值
        Person *p1 = [[Person alloc] init];
        p1.name = @"张三";
        
        Dog *chihuahua = [[Dog alloc] init];
        chihuahua.name = @"吉娃娃";
        p1.dog = chihuahua;
        NSLog(@"%@------%@",p1.name,p1.dog.name);
        
        //通过kvc的方式为对象赋值
        Dog *husky = [[Dog alloc] init];
        husky.name = @"哈士奇";
        
        [p1 setValue:@"李四" forKeyPath:@"name"];
        [p1 setValue:@10 forKeyPath:@"age"];
        //@10转化成NSNumber

        [p1 setValue:husky forKeyPath:@"dog"];
        NSLog(@"%@------%d-----%@",p1.name,p1.age,p1.dog.name);
        
        //展现灵活性
        //NSString *value = @"asasasa@qq.com";
        NSString *value = @"啊哈哈";
        //NSString *property = @"email";
        NSString *property = @"name";
        [p1 setValue:value forKeyPath:property];
        NSLog(@"%@------%@",p1.name,p1.email);
        
        
        //字典数组赋值
        NSDictionary *bz = @{
            @"name" : @"啊啊吧",
            @"age" : @20,
            @"email" : @"123@qq.com",
            @"dog" : @{@"name" : @"哈士奇"}
        };
        [p1 setValuesForKeysWithDictionary:bz];
        NSDictionary *dogDict = (NSDictionary *)p1.dog;
        //这里需要转化一下，因为赋值的时候没有转成模型
        //直接将字典数组 @{@"name" : @"哈士奇"}赋给dog属性
        //dog是一个字典
        NSLog(@"%@=======%d======%@======%@",p1.name,p1.age,p1.email,dogDict[@"name"]);
        
        //path
        [p1 setValue:@"那男" forKeyPath:@"name"];
        [p1 setValue:@100 forKeyPath:@"age"];
        //@10转化成NSNumber
        [p1 setValue:@"aaaaa@qq.com" forKeyPath:@"email"];
        [p1 setValue:chihuahua forKeyPath:@"dog"];
        [p1 setValue:@"小狗狗gggg" forKeyPath:@"dog.name"];
        //keyPath属性路径dog.name，可以这么点出来
        NSLog(@"%@------%d-----%@",p1.name,p1.age,p1.dog.name);
        
        //拿到属性的数据
        NSString *name = [p1 valueForKeyPath:@"name"];
        NSString *dogName = [p1 valueForKeyPath:@"dog.name"];
        NSLog(@"%@,,,,,%@",name,dogName);
        
        
        //把一个对象转化成字典
        NSDictionary *dict = [p1 dictionaryWithValuesForKeys:@[@"name",@"age",@"email",@"dog"]];
        NSLog(@"%@",dict);
        NSLog(@"%@",[dict[@"dog"] class]);
        NSLog(@"%@",[dict[@"dog"] name]);
        //字典里面的dog键的值是一个狗对象
    }
    return 0;
}
