//
//  confirmViewController.h
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "additionData.h"

@interface confirmViewController : UIViewController
{
    additionData *_addData;
}
@property additionData *addData;
@property (weak, nonatomic) IBOutlet UILabel *makerLabel;
@property (weak, nonatomic) IBOutlet UILabel *softwareLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;


- (IBAction)makerEdit:(id)sender;
- (IBAction)softwareEdit:(id)sender;
- (IBAction)versionEdit:(id)sender;
- (IBAction)tagEdit:(id)sender;
- (IBAction)keyEdit:(id)sender;
- (IBAction)startEdit:(id)sender;
- (IBAction)periodEdit:(id)sender;



- (IBAction)sendBtn:(id)sender;

@end
