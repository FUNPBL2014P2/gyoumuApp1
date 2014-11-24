//
//  finishAddingViewController.h
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/25.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "additionData.h"

@interface finishAddingViewController : UIViewController
{
    additionData *_addData;
}
@property additionData *addData;
@property (weak, nonatomic) IBOutlet UILabel *message;
- (IBAction)continueBtn:(id)sender;
- (IBAction)returnBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
@property (weak, nonatomic) IBOutlet UIButton *returnBtn;

@end
