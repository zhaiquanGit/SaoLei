//
//  VC_SetUp.m
//  SaoLei
//
//  Created by aoi on 14-12-3.
//  Copyright (c) 2014年 aoi. All rights reserved.
//

#import "VC_SetUp.h"

@interface VC_SetUp ()

@end

@implementation VC_SetUp

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _textX.placeholder = @"行数";
    _textY.placeholder = @"列数";
    _textL.placeholder = @"地雷数量";
    
    _textX.delegate = self;
    _textY.delegate = self;
    _textL.delegate = self;
    
    

    // COCOCOOCO
    
    _textX.keyboardAppearance = UIKeyboardTypeNumberPad;
    
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

- (IBAction)_yes:(id)sender {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSMutableDictionary *MuDic_Plist = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSMutableDictionary *MuDic_Plist_Set = [MuDic_Plist objectForKey:@"Set"];
    
    [MuDic_Plist_Set removeAllObjects];
    
    /*
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"test.plist"];*/
    int x,y,l;
    x = [_textX.text intValue];
    y = [_textY.text intValue];
    l = [_textL.text intValue];
    

    [MuDic_Plist_Set setObject:[NSNumber numberWithInt:x] forKey:@"X"];
    [MuDic_Plist_Set setObject:[NSNumber numberWithInt:y] forKey:@"Y"];
    [MuDic_Plist_Set setObject:[NSNumber numberWithInt:l] forKey:@"L"];
    
    

    [MuDic_Plist writeToFile:plistPath atomically:YES];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)_no:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#define mark - Tasdsa
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (IBAction)_vtuo:(id)sender {
    [_textX resignFirstResponder];
    [_textY resignFirstResponder];
    [_textL resignFirstResponder];
}
@end
