//
//  ViewController.h
//  SaoLei
//
//  Created by aoi on 14-12-3.
//  Copyright (c) 2014年 aoi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController



@property (weak, nonatomic) IBOutlet UIButton *buRank;
@property (weak, nonatomic) IBOutlet UIButton *buSetUp;


- (IBAction)_begin:(id)sender;
- (IBAction)rank:(UIButton *)sender;
- (IBAction)setup:(UIButton *)sender;



@end

