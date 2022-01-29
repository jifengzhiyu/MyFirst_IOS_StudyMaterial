//
//  ViewController.m
//  06-通讯录不带 UI
//
//  Created by Romeo on 15/9/24.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>
//Core Foundation 和 Fundation 桥接的问题 --> 面试题
//1. 有几种方式 2. 注意事项 注意释放 CF 对象

//将 CF 对象给 Foundatian

//1. (__bridge type)<#expression#>) : 只是让 Foundation 框架暂时使用 CF 框架对象
//2. (__bridge_transfer )) / CFBridgingRelease : CF框架移交对象的管理权给 Foundation 框架

//将 Foundatian给 CF 对象 不常用

//3. (__bridge_retained <#CF type#>)<#expression#>)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 点击屏幕获取所有联系人信息
    
    //1. 判断是否授权成功, 授权成功才能获取数据
    if ( ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
     
        //2. 创建通讯录
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        
        //3. 获取联系人  --> Array
        CFArrayRef peosons = ABAddressBookCopyArrayOfAllPeople(addressBook);
        
        //4. 遍历联系人来获取数据(姓名和电话)
        CFIndex count = CFArrayGetCount(peosons);
        //strong 和 retain 都是针对对象类型进行内存管理。如果去修饰基本数据类型,Xcode会直接报错
        //所以count不需要release
        
        for (CFIndex i = 0 ; i < count; i++) {
            
            //5. 获取单个联系人
            ABRecordRef person = CFArrayGetValueAtIndex(peosons, i);
            
            //6. 获取姓名
            NSString *lastName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
            NSString *firstName  = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
            NSLog(@"lastName: %@, firstName: %@", lastName, firstName);
            
            //7. 获取电话
            ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
            
            //7.1 获取 count
            CFIndex phoneCount = ABMultiValueGetCount(phones);
            
            //7.2 遍历ABMultiValueRef
            for (CFIndex i = 0; i < phoneCount; i++) {
                NSString *label = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phones, i));
                NSString *value = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, i));
                NSLog(@"label: %@, value: %@",label, value);
            }
            
            NSLog(@"\n\n");
            
            //8.1 释放 CF 对象
            CFRelease(phones);
        }
        
        //8.1 释放 CF 对象
        CFRelease(peosons);
        CFRelease(addressBook);
        
    }

}

@end
