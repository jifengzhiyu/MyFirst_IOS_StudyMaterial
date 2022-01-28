//
//  main.m
//  文件终结者
//
//  Created by 翟佳阳 on 2021/8/24.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    while(1){
        NSFileManager * fileManager = [NSFileManager defaultManager];
        NSString * path = @"/Users/kaixin/Documents/aba/";
        NSArray * arr = [fileManager contentsOfDirectoryAtPath:path error:nil];
        //获取指定文件夹下的子目录（一辈），相对路径，需要newP来将路径补充为绝对路径
        if(arr.count > 0)
        {
            for(NSString * p in arr)
            {
                NSString * newP = [NSString stringWithFormat:@"%@%@",path,p];
                if([fileManager isDeletableFileAtPath:newP])
                    //判断能否删除
                {
                    [fileManager removeItemAtPath:newP error:nil];
                    //删除文件
                }
            }
        }
        NSLog(@"扫描完成");
        [NSThread sleepForTimeInterval:1];
        //每秒钟扫描一次
    }
   
    return 0;
}
