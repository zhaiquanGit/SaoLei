//
//  ViewController.m
//  扫雷
//
//  Created by imti Azusa on 14-9-29.
//  Copyright (c) 2014年 Azusa. All rights reserved.
//

#import "ViewController.h"
#import "MyButton.h"

@interface ViewController ()

{
    NSMutableArray *MuArr;
}

@end



@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define N       20  // 单元格边长
#define MAXX    15  // x轴数量
#define MAXY    25  // y轴数量 // 20
#define MAXDL   50  // 地雷数量

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    MuArr = [NSMutableArray arrayWithCapacity:MAXY];
    
    for (int y=0; y<MAXY; y++) {
        [MuArr addObject:[NSMutableArray arrayWithCapacity:MAXX]];
        for (int x=0; x<MAXX; x++) {
            MyButton *bu = [MyButton buttonWithType:UIButtonTypeRoundedRect];
            bu.backgroundColor = [UIColor greenColor];
            bu.frame = CGRectMake(10+N*x, 60+N*y, N-2, N-2);
            [bu setTitle:@"" forState:UIControlStateNormal];
            bu.tag = x + y*100 + 10000;
            bu.x = x;
            bu.y = y;
            [bu addTarget:self action:@selector(BU:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:bu];
            [MuArr[y] addObject:bu];
        }
    }
    
    int i = 0;
    int x;
    int y;
    // 生成地雷
    while (YES) {
        x = arc4random_uniform(MAXX);
        y = arc4random_uniform(MAXY);
        MyButton *bu = MuArr[y][x];
        if (bu.L == 0) {
            bu.L = 1;
            ++i;
            if (i==MAXDL) {
                break;
            }
        }
    }
    
    // 获取周围地雷数量
    for (int y=0; y<MAXY; y++) {
        for (int x=0; x<MAXX; x++) {
            MyButton *bu = MuArr[y][x];
            for (int _y=y-1; _y<y+2; _y++) {
                if (_y<0 || _y>=MAXY) {
                    continue;
                }
                for (int _x=x-1; _x<x+2; _x++) {
                    if (_x<0 || _x>=MAXX) {
                        continue;
                    }
                    MyButton *_bu = MuArr[_y][_x];
                    bu.n += _bu.L;
                }
            }
            bu.strN = [NSString stringWithFormat:@"%d", bu.n];
        }
    }
    
    
    
    // 测试
    for (int y=0; y<MAXY; y++) {
        for (int x=0; x<MAXX; x++) {
            MyButton *bu = MuArr[y][x];
            
            if (bu.L == 1) {    // 显示地雷
//                bu.backgroundColor = [UIColor blackColor];
            }
//            NSString *st;
            if (bu.n>0) {       // 显示周围地雷个数
//                [bu setTitle:bu.strN forState:UIControlStateNormal];
            }
            else {      // 显示空白方块
//                bu.backgroundColor = [UIColor yellowColor];
            }
            
        }
    }
    
}

-(void)BU:(MyButton *)bu
{
    // 如果经过判断，则返回
    if (bu.P==1) {
        return;
    }
    else {
        bu.P = 1;   // 添加判断标记
    }
    
    // 测试
    printf("%d %d\n", bu.y, bu.x);
    
    // 如果存在地雷，game over
    if (bu.L==1) {
        [bu setTitle:@"*" forState:UIControlStateNormal];
        printf("Game Over\n");
        return;
    }
    bu.backgroundColor = [UIColor yellowColor];
    // 如果周围地雷数量为0,则打开方块
    if (bu.n == 0) {
        // 颜色设置为空
//        bu.backgroundColor = [UIColor yellowColor];
        // 继续打开周围方块
        for (int _y=bu.y-1; _y<bu.y+2; _y++) {
            if (_y<0 || _y>=MAXY) {
                continue;   // 如果超出范围，退出本次循环
            }
            for (int _x=bu.x-1; _x<bu.x+2; _x++) {
                if (_x<0 || _x>=MAXX) {
                    continue;   // 如果超出范围，退出本次循环
                }
                // 继续递归判断
                MyButton *_bu = MuArr[_y][_x];
//                _bu.backgroundColor = [UIColor yellowColor];
                [self BU:_bu];
            }
        }
        return;
    }
    else {  // 如果周围存在地雷，则显示地雷数量
        [bu setTitle:bu.strN forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)TT:(id)sender {
}
@end
