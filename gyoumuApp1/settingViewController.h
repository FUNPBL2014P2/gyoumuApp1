//
//  settingViewController.h
//  gyoumuApp1
//
//  Created by FUNAICT201312 on 2014/11/25.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface settingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *allResetLabel;
- (IBAction)allResetBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *allBadgeResetLabel;
- (IBAction)allBadgeResetBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *badgeResetLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeResetNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *resetBadgeNumber;
- (IBAction)badgeResetBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *evaluateResetLabel;
- (IBAction)evaluateResetBtn:(id)sender;

- (IBAction)demoResetBtn:(id)sender;

@end
