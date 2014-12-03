//
//  VC_SetUp.h
//  SaoLei
//
//  Created by aoi on 14-12-3.
//  Copyright (c) 2014年 aoi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_SetUp : UIViewController
<UITextFieldDelegate>

- (IBAction)_yes:(id)sender;
- (IBAction)_no:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textX;
@property (weak, nonatomic) IBOutlet UITextField *textY;
@property (weak, nonatomic) IBOutlet UITextField *textL;
- (IBAction)_vtuo:(id)sender;

@end
