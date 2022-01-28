//
//  main.m
//  集合的内存管理
//
//  Created by 翟佳阳 on 2021/8/23.
//
#define LogBOOL(val) NSLog(@"%@",val == YES? @"YES":@"NO")
#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL res = [fileManager removeItemAtPath:@"/Users/kaixin/Documents/my_github/Objective_C/黑马/untitled.txt" error:nil];
    if(res == YES)
                   {
                       NSLog(@"成功");
                   }
                   else
                   {
                       NSLog(@"失败");
                   }
//    BOOL res = [fileManager moveItemAtPath:@"/Users/kaixin/Documents/my_github/Objective_C/黑马/10Foundation框架2/untitled.txt" toPath:@"/Users/kaixin/Documents/my_github/Objective_C/黑马/untitled.txt" error:nil];
//    if(res == YES)
//               {
//                   NSLog(@"成功");
//               }
//               else
//               {
//                   NSLog(@"失败");
//               }
    
//    BOOL res = [fileManager copyItemAtPath:@"/Users/kaixin/Documents/my_github/Objective_C/黑马/10Foundation框架2/10.md" toPath:@"/Users/kaixin/Documents/my_github/Other-notes/10.md" error:nil];
//    if(res == YES)
//           {
//               NSLog(@"成功");
//           }
//           else
//           {
//               NSLog(@"失败");
//           }
    
//    BOOL res = [fileManager createDirectoryAtPath:@"/Users/kaixin/Documents/my_github/Objective_C/黑马/AA/BB/CC" withIntermediateDirectories:YES attributes:nil error:nil];
//    if(res == YES)
//       {
//           NSLog(@"成功");
//       }
//       else
//       {
//           NSLog(@"失败");
//       }
    
//    NSString * str = @"我爱赚钱";
//    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    BOOL  res = [fileManager createFileAtPath:@"/Users/kaixin/Documents/my_github/Objective_C/黑马/haha.tex" contents:data attributes:nil];
//    if(res == YES)
//    {
//        NSLog(@"成功");
//    }
//    else
//    {
//        NSLog(@"失败");
//    }
    
    
//    NSArray * arr = [fileManager contentsOfDirectoryAtPath:@"/Users/kaixin/Documents/xcode_projs" error:nil];
//   // NSArray * arr = [fileManager subpathsAtPath:@"/Users/kaixin/Documents/xcode_projs"];
//    NSLog(@"%@",arr);
//    for(NSString * str in arr)
//    {
//        NSLog(@"%@",str);
//    }
//    NSDictionary * dict = [fileManager attributesOfItemAtPath:@"/Users/kaixin/Documents/xcode_projs" error:nil];
//    NSLog(@"%@",dict);
//    NSLog(@"%@",dict[NSFileSize]);
    
//    BOOL res = [fileManager isDeletableFileAtPath:@"/Users/kaixin/Documents/pl.plist"];
//    //BOOL res = [fileManager isWritableFileAtPath:@"/Users/kaixin/Documents/pl.plist"];
//    //BOOL res = [fileManager isReadableFileAtPath:@"/Users/kaixin/Documents/pl.plist"];
//    LogBOOL(res);
//    BOOL flag = NO;
//    BOOL res = [fileManager fileExistsAtPath:@"/Users/kaixin/Documents/p.plist" isDirectory:&flag];
//    if(res == YES)
//    {
//        NSLog(@"存在路径");
//        if(flag == YES)
//        {
//            NSLog(@"是文件夹");
//        }
//        else{
//            NSLog(@"是文件");
//        }
//    }else
//    {
//        NSLog(@"给定的路径不存在");
//    }
//
//    NSString * path = @"/Users/kaixin/Documents/pl.plist";
//    BOOL res = [fileManager fileExistsAtPath:path];
//    LogBOOL(res);

//    NSArray * arr1 = [NSArray arrayWithObjects:@"jack",@"helen", nil];
//    NSArray * arr2 = @[@"jack",@"helen"];
//
//    Person * p1 = [Person new];
//    NSLog(@"%lu",p1.retainCount);
//    NSArray * arr = @[p1];
//    NSLog(@"%lu",p1.retainCount);//- 将对象存储在集合中，该对象的引用计数器+1
//
//
//
//
//    [arr release];
//    //当集合销毁的时候，会向存储在集合中的所有对象发送release消息
//    NSLog(@"%lu",p1.retainCount);
//
//    [p1 release];
    return 0;
}
