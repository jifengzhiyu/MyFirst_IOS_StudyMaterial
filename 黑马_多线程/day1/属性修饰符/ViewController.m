//
//  ViewController.m
//  属性修饰符
//
//  Created by 翟佳阳 on 2021/10/19.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()
//@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSString *name;

//@property (nonatomic, assign) void(^myBlock)(void);
@property (nonatomic, copy) void(^myBlock)(void);

@property (nonatomic, strong) Person *person;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.

    //字符串用copy
   {
//    NSMutableString *str = [NSMutableString string];
//    [str appendString:@"hello"];
//    //strong时
//    //让self.name地址指向str
//    //self.name是NSString *name 是地址
//    //str是NSMutableString *str 是地址
//    //赋值地址的话就会实时更新
//
//
//    //copy时
//    //self.name = str;把可变数组复制成一份不可变数组，把不可变数组付给name
//
//    self.name = str;
//
//    [str appendString:@"-------abababbababab"];
//        NSLog(@"%@",self.name);}
}
    
    
    //block用copy
    {

//    [self test];
//    self.myBlock();
//    //如果调用第二遍block，会出现僵尸对象问题,blcok已经被释放了
//    //Thread 1: EXC_BAD_ACCESS (code=2, address=0x12d80c210)
//    //它是栈block，超过作用域就会被释放掉，其实第一次调用就有问题
//    self.myBlock();
    }
    
    
    //delegate用weak
    {
    self.person = [Person new];
    self.person.delegate = self;
    //如果delegate用strong:
    /*
     控制器--->person--->delegate---->self（控制器
     控制器强引用person：person在控制器里用strong
     person强引用delegate:属性用strong
     delegate强引用控制器：self.person.delegate = self;
     造成了循环引用
     */
    }
}

//给block属性赋值
//copy属性：给blcok赋值时自动赋值copy之后的
//由栈block变成堆blcok
- (void)test{
    int n = 5;
    [self setMyBlock:^{
            NSLog(@"%d",n);
    }];
    NSLog(@"set finished");
    NSLog(@"%@",self.myBlock);
}

@end
