//
//  main.m
//  微博练习
//
//  Created by 翟佳阳 on 2021/8/15.
//

/*
 在MRC模式下
 一、微博类（Microblog)
 属性：
 文字内容
 图片
 发表时间（NAAtring*)
 作者
 被转发的微博
 评论数
 转发数
 点赞数
 
 二、作者类(User)
 名称
 生日
 找好
 
 三、账号类
 名称
 密码 
 注册时间（NSString*)
 */
#import <Foundation/Foundation.h>
#import "Microblog.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Account *a1 = [[Account new] autorelease];
        a1.userName = @"jifengzhiyu";
        a1.password = @"hahaha";
        a1.registDate = (KXDate){
            2021,12,3
        };
        
        User* jifeng = [[User new] autorelease];
        jifeng.nickName = @"霁风";
        jifeng.brithday = (KXDate){
            2007,3,3
        };
        jifeng.account = a1;
        
         Microblog* b1 =[[Microblog new]autorelease];
        b1.content = @"今天天气真好，我们一起去散步吧";
        b1.imgURL = @"http://www.jifeng.cn/logo,gif";
        b1.user = jifeng;
        b1.zhuanFaBlog = nil;
        
        
        Account *a2 = [[Account new] autorelease];
        a2.userName = @"wahaha";
        a2.password = @"hahaha";
        a2.registDate = (KXDate){
            2021,12,3
        };
        
        User* wahaha = [[User new] autorelease];
        wahaha.nickName = @"哇哈哈";
        wahaha.brithday = (KXDate){
            2007,3,3
        };
        wahaha.account = a2;
        
         Microblog* b2 =[[Microblog new]autorelease];
        b2.content = @"不去";
        b2.imgURL = @"http://www.jifeng.cn/logo,gif";
        b2.user = wahaha;
        b2.zhuanFaBlog = b1;
        
        }
    
    return 0;
}
