//
//  VC_Begin.m
//  SaoLei
//
//  Created by aoi on 14-12-3.
//  Copyright (c) 2014年 aoi. All rights reserved.
//

#import "VC_Begin.h"
#import "MyButton.h"

@interface VC_Begin ()

{
    // 长宽
    int _X,_Y,_MAX_X,_MAX_Y,_MIN_X,_MIN_Y;
    
    // 地雷数量
    int _L;
    
    // 保存按钮对象
    NSMutableArray *_MuArr;
    
    // 第一次点击
    BOOL _INIT;
}

@end

#define N 30

@implementation VC_Begin

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 //   self.navigationController.navigationBarHidden = NO;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"IMAGE1"]];
    
    // 读取plist,初始化变量值
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSMutableDictionary *MuDic_Plist = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@", MuDic_Plist);
    
    NSMutableDictionary *MuDic_Plist_Set = [MuDic_Plist objectForKey:@"Set"];
    _X = [[MuDic_Plist_Set objectForKey:@"X"] intValue];
    _Y = [[MuDic_Plist_Set objectForKey:@"Y"] intValue];
    _L = [[MuDic_Plist_Set objectForKey:@"L"] intValue];

    
    
    
    
    _INIT = YES;
    
    
    /////////////
    
    int __x, __y;
    __x = (375 - N*_X)/2;
    __y = (667 - N*_Y)/2;
    
    // 初始化游戏界面
    _MuArr = [NSMutableArray arrayWithCapacity:_Y];
    for (int y=0; y<_Y; y++) {
        [_MuArr addObject:[NSMutableArray arrayWithCapacity:_X]];
        for (int x=0; x<_X; x++) {
            MyButton *bu = [MyButton buttonWithType:UIButtonTypeRoundedRect];
            bu.backgroundColor = [UIColor greenColor];
            bu.frame = CGRectMake(__x+N*x, __y+N*y, N-2, N-2);
            [bu setTitle:@"" forState:UIControlStateNormal];
            bu.tag = x + y*100 + 10000;
            bu.x = x;
            bu.y = y;
            [bu addTarget:self action:@selector(BU:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:bu];
            [_MuArr[y] addObject:bu];
        }
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)_return:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)_again:(id)sender {
    for (int y=0; y<_Y; y++) {
        for (int x=0; x<_X; x++) {
            MyButton *bu = _MuArr[y][x];
            bu.backgroundColor = [UIColor greenColor];
            [bu setTitle:@"" forState:UIControlStateNormal];
            bu.L = 0;
            bu.n = 0;
            bu.P = 0;
        }
    }
    _INIT = YES;
}



-(void)BU:(MyButton *)bu
{
    // 第一次开始初始化
    if (_INIT) {
        [self initSL:bu];
    }
    
    ///
    // 如果经过判断，则返回
    if (bu.P==1) {
        return;
    }
    else {
        bu.P = 1;   // 添加判断标记
    }
    
    // 测试
    //   printf("%d %d\n", bu.y, bu.x);
    
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
            if (_y<0 || _y>=_Y) {
                continue;   // 如果超出范围，退出本次循环
            }
            for (int _x=bu.x-1; _x<bu.x+2; _x++) {
                if (_x<0 || _x>=_X) {
                    continue;   // 如果超出范围，退出本次循环
                }
                // 继续递归判断
                MyButton *_bu = _MuArr[_y][_x];
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

-(void)initSL:(MyButton *)button
{
    NSLog(@"AN");
    int i = 0;
    int x;
    int y;
    // 生成地雷
    while (YES) {
        x = arc4random_uniform(_X);
        y = arc4random_uniform(_Y);
        // 保证第一次不会点击到地雷
        if (x==button.x && y==button.y) {
            continue;
        }
        MyButton *bu = _MuArr[y][x];
        if (bu.L == 0) {
            bu.L = 1;
            ++i;
            if (i==_L) {
                break;
            }
        }
    }
    
    // 获取周围地雷数量
    for (int y=0; y<_Y; y++) {
        for (int x=0; x<_X; x++) {
            MyButton *bu = _MuArr[y][x];
            for (int _y=y-1; _y<y+2; _y++) {
                if (_y<0 || _y>=_Y) {
                    continue;
                }
                for (int _x=x-1; _x<x+2; _x++) {
                    if (_x<0 || _x>=_X) {
                        continue;
                    }
                    MyButton *_bu = _MuArr[_y][_x];
                    bu.n += _bu.L;
                }
            }
            bu.strN = [NSString stringWithFormat:@"%d", bu.n];
        }
    }
    
    for (int y=0; y<_Y; y++) {
        for (int x=0; x<_X; x++) {
            MyButton *bu = _MuArr[y][x];
            printf("%d ", bu.L);
            //   NSLog(@"%d ", bu.L);
        }
        printf("\n");
        //NSLog(@"\n");
    }
    
    //
    _INIT = NO;
    
    
    /*
    // 测试
    for (int y=0; y<_Y; y++) {
        for (int x=0; x<_X; x++) {
            MyButton *bu = _MuArr[y][x];
            
            if (bu.L == 1) {    // 显示地雷
                //bu.backgroundColor = [UIColor blackColor];
            }
            //            NSString *st;
            if (bu.n>0) {       // 显示周围地雷个数
                //                [bu setTitle:bu.strN forState:UIControlStateNormal];
            }
            else {      // 显示空白方块
                //                bu.backgroundColor = [UIColor yellowColor];
            }
            
        }
    }*/
}


@end
