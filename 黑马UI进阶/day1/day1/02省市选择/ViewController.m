//
//  ViewController.m
//  02省市选择
//
//  Created by 翟佳阳 on 2021/9/25.
//

#import "ViewController.h"
#import "Province.h"
@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *cityLbl;
@property (weak, nonatomic) IBOutlet UILabel *provinceLbl;
@property (nonatomic, copy) NSArray *provinces;
//用来保存每次后台刷新后选中的省
@property (nonatomic, strong)Province *selProvince;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //标签初始化
    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
    
}

# pragma mark - 懒加载
- (NSArray *)provinces{
    if(!_provinces){
        //初始array
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"省份城市.plist" ofType:nil]];
        //返回一个特定容量的可变数组
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:dictArr.count];
        
        for (NSDictionary *dict in dictArr) {
            Province *pro = [Province provinceWithDict:dict];
            [arrM addObject:pro];
        }
        _provinces = arrM;
    }
    return _provinces;
}

# pragma mark - 代理方法
///刷新,赋值标签
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        [pickerView reloadComponent:1];
        
        //默认刷新选中第0行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    
    //显示标签
    //1、获取索引
    NSInteger selProIdx = [pickerView selectedRowInComponent:0];
    NSInteger selCityIdx = [pickerView selectedRowInComponent:1];
    
    //2、获取数据
    Province *selPro = self.provinces[selProIdx];
    //NSString *selCity = selPro.cities[selCityIdx];
    NSString *selCity = self.selProvince.cities[selCityIdx];
    
    //3、赋值
    self.provinceLbl.text = selPro.name;
    self.cityLbl.text = selCity;
}

///显示每一行的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    //分组讨论
    if(component == 0){
        Province *pro = self.provinces[row];
        
        return pro.name;
    }else{
        //不要这里选中的城市，因为是根据上一个省份确定的
//        NSInteger selProIdx = [pickerView selectedRowInComponent:0];
//        Province *selPro = self.provinces[selProIdx];
//
//        return selPro.cities[row];
        return self.selProvince.cities[row];
    }
}

# pragma mark - 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    //如果是第0组，返回省 份数量，如果是第1组，返回城市数量
    if(component == 0){
        return self.provinces.count;
    }else{
        //1、获取当前的省份
        //获取当前省的行号
        NSInteger selProIdx = [pickerView selectedRowInComponent:0];
        //获取当前省
        Province *selPro = self.provinces[selProIdx];
        _selProvince = selPro;
        
        //加载省完了，要加载城市
        
        //用来保存最开始加载当前选中的省份
        
        //2、根据省份决定城市的行数
//        return selPro.cities.count;
        return self.selProvince.cities.count;
    }
}


@end
