//
//  inputDateViewController.h
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "additionData.h"

@interface inputDateViewController : UIViewController
{
    additionData *_addData;
}
@property additionData *addData;
@property (weak, nonatomic) IBOutlet UIDatePicker *startPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *periodPicker;
@property (weak, nonatomic) IBOutlet UISwitch *periodState;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
- (IBAction)next:(id)sender;
-(void)changedSwitchValue:(UISwitch*)state;
@end
