//
//  ViewController.m
//  day1
//
//  Created by 翟佳阳 on 2021/9/23.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
- (IBAction)randomBtnClick;
@property (weak, nonatomic) IBOutlet UILabel *fruitLbl;
@property (weak, nonatomic) IBOutlet UILabel *mainFoodLbl;
@property (weak, nonatomic) IBOutlet UILabel *drinkLbl;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *foods;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //先设置一个默认的数据
    for(int i = 0; i < self.foods.count; i++){
    [self pickerView:self.pickerView didSelectRow:0 inComponent:i];
    }
}

#pragma mark -代理方法
//显示数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSArray *comFoods = self.foods[component];
//    NSString *food = comFoods[row];
    NSString *food = self.foods[component][row];
    return food ;
}

//选中某一组的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *selFood = self.foods[component][row];
    switch (component) {
        case 0:
            self.fruitLbl.text = selFood;
            break;
        case 1:
            self.mainFoodLbl.text = selFood;
            break;
        case 2:
            self.drinkLbl.text = selFood;
            break;
            
        default:
            break;
    }

}

#pragma mark - 数据源方法
//返回多少组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.foods.count;
}

//返回每组有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.foods[component] count];
}


# pragma mark - 懒加载
//字典转模型，字符串不需要转模型
- (NSArray *)foods{
    if(_foods == nil){
        _foods = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"foods.plist" ofType:nil]];
    }
    return _foods;
}

//随机点餐
- (IBAction)randomBtnClick {
    //遍历集合中的所有数组
    for(int i = 0; i < self.foods.count; i++){
    //第i组里面的数据个数
        NSInteger count = [self.foods[i] count];
        //生成随机数
        int ranNum = arc4random_uniform((int)count);
        //强行转化成int类型
        
        //获取第i组当前所选中的行
        NSInteger selRowNum = [self.pickerView selectedRowInComponent:i];
        
        //如果之前生成随机数与当前被选中行数一致，就再生成一个随机数，直到两个者不一样为止
        while (selRowNum == ranNum) {
            ranNum = arc4random_uniform((int)count);
        }
        
        //让picjerView选中随机数数据
        [self.pickerView selectRow:ranNum inComponent:i animated:YES];
        //将数据显示到标签上
        [self pickerView:self.pickerView didSelectRow:ranNum inComponent:i];
    }
}
@end
