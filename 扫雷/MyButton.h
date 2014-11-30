//
//  MyButton.h
//  扫雷
//
//  Created by imti Azusa on 14-9-29.
//  Copyright (c) 2014年 Azusa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyButton : UIButton

// 位置
@property (nonatomic) int x;
@property (nonatomic) int y;



// 状态  0空白 1地雷
@property (nonatomic) int L;

// 周围地雷数量
@property (nonatomic) int n;
@property (retain, nonatomic) NSString *strN;

// 判断
@property (nonatomic) int P;

@end
