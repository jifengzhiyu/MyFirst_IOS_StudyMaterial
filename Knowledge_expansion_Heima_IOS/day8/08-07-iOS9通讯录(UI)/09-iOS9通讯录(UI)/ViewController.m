//
//  ViewController.m
//  09-iOS9通讯录(UI)
//
//  Created by Romeo on 15/9/24.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "ViewController.h"
//#import <AddressBookUI/AddressBookUI.h>
#import <ContactsUI/ContactsUI.h>

@interface ViewController ()<CNContactPickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    ABPeoplePickerNavigationController *picker = [ABPeoplePickerNavigationController new];
//    
//    picker.peoplePickerDelegate = self;
    
    
    //iOS9 新出
    
    //1. 创建控制器
    CNContactPickerViewController *contactVC = [CNContactPickerViewController new];
    
    //2. 设置代理
    contactVC.delegate = self;
    
    //3. 弹出
    [self presentViewController:contactVC animated:YES completion:nil];
}


/**
 选择联系人的时候调用
 */
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
//{
//    //1. 获取姓名
//    //givenName: firstName
//    //familyName : lastName
//    NSLog(@"givenName: %@, familyName: %@", contact.givenName, contact.familyName);
//
//    //2. 获取电话  --> 泛型 会在数组遍历是帮很大的忙
//    for (CNLabeledValue *labeledValue in contact.phoneNumbers) {
//        NSLog(@"label: %@",labeledValue.label);
//
//        CNPhoneNumber *phoneNumber = labeledValue.value;
//
//        NSLog(@"phoneNumber: %@",phoneNumber.stringValue);
//    }
//}

/**
 实现了此方法, 就可以选择多个联系人
 */
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact *> *)contacts
{
    for (CNContact *contact in contacts) {

        NSLog(@"givenName: %@, familyName: %@", contact.givenName, contact.familyName);

        //2. 获取电话  --> 泛型 会在数组遍历是帮很大的忙
        //@property(readonly, copy, nonatomic) NSArray<CNLabeledValue<CNPhoneNumber *> *> *phoneNumbers;
        for (CNLabeledValue *labeledValue in contact.phoneNumbers) {
            NSLog(@"label: %@",labeledValue.label);

            CNPhoneNumber *phoneNumber = labeledValue.value;

            NSLog(@"phoneNumber: %@",phoneNumber.stringValue);
        }
    }
}



//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
//{
//    
//}


//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty *> *)contactProperties
//{
//    
//}





- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker
{
    
}

@end
