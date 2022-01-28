//
//  ViewController.m
//  国旗选择
//
//  Created by 翟佳阳 on 2021/9/26.
//

#import "ViewController.h"
#import "Flag.h"
#import "FlagView.h"
@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, copy) NSArray *flags;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSArray *)flags{
    if(!_flags){
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"国旗.plist" ofType:nil]];
        
        NSMutableArray *temp = [NSMutableArray arrayWithCapacity:dictArr.count];
        
        for (NSDictionary *dict in dictArr) {
            Flag *flag = [Flag flagWithDict:dict];
            [temp addObject:flag];
        }
        _flags = temp;
    }
    return _flags;
    }

#pragma mark - 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.flags.count;
}

#pragma mark - 代理方法
///返回UIView类型，图片(国旗 加文字（国名
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //1、创建view 
    FlagView *flagView = [FlagView flagView];
    //2、设置数据
    flagView.flag = self.flags[row];
    //3、返回数据
    return flagView;
}

//返回行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return [FlagView rowHeight];
}
@end
