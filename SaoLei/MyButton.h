//
//  MyButton.h
//  SaoLei
//
//  Created by aoi on 14-12-3.
//  Copyright (c) 2014年 aoi. All rights reserved.
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
