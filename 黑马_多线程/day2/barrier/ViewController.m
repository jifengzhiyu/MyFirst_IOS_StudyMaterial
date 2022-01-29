//
//  ViewController.m
//  barrier
//
//  Created by 翟佳阳 on 2021/10/20.
//

#import "ViewController.h"

@interface ViewController ()
//C语言之下：定义成员变量：相当于属性
{
    dispatch_queue_t _queue;
}
@property (nonatomic, strong) NSMutableArray *phtolist;


@end

@implementation ViewController
- (NSMutableArray *)phtolist{
    if(_phtolist == nil){
        _phtolist = [NSMutableArray array];
    }
    return _phtolist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //并发队列
    _queue = dispatch_queue_create("jf", DISPATCH_QUEUE_CONCURRENT);
    // Do any additional setup after loading the view.
    for(int i = 1; i <= 10; i++){
        [self downloadImage:i];
    }
}

//下载图片
- (void)downloadImage:(int)index{
    
    dispatch_async(_queue,^{
        
        NSString *fileName = [NSString stringWithFormat:@"%02d.jpg",index];
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        //阻塞，等队列中的所有任务执行完成，才会执行barrier中的代码
        //使用一个线程（最后一个线程上）
        //使用barrier只能使用并发队列（而不是全局队列）
        dispatch_barrier_async(self->_queue, ^{
            
            [self.phtolist addObject:image];
            NSLog(@"保存图片-- %@---%@",fileName,[NSThread currentThread]);
            
        });
        
        NSLog(@"下载完成--%@---%@",fileName,[NSThread currentThread]);
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%zd",self.phtolist.count);
    
    //无论放在哪里都只执行一次
    //执行在当前线程里面
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 2; i++) {
            //静态全局变量，初始0，来控制block内只执行一次
            static dispatch_once_t onceToken;
            NSLog(@"token--before--%zd",onceToken);
            dispatch_once(&onceToken, ^{
                NSLog(@"once111111%@",[NSThread currentThread]);
                NSLog(@"token--after--%zd",onceToken);

            });
        }
    });
   
    for (int i = 0; i < 300; i++) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSLog(@"once222222222%@",[NSThread currentThread]);
        });
    }
    
    
    
}

@end
