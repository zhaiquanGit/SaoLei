//
//  ViewController.m
//  SaoLei
//
//  Created by aoi on 14-12-3.
//  Copyright (c) 2014年 aoi. All rights reserved.
//

#import "ViewController.h"
#import "MyButton.h"

@interface ViewController ()



@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self.navigationController setToolbarHidden:NO];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"IMAGE1"]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)begin:(UIButton *)sender {
    
    
}

- (IBAction)rank:(UIButton *)sender {
    
    
}

- (IBAction)setup:(UIButton *)sender {
//    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"11" message:123 delegate:nil cancelButtonTitle:@"12" otherButtonTitles:nil, nil];
}

- (IBAction)_begin:(id)sender {
}



@end
