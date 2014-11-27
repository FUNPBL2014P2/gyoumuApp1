//
//  licenseKeyViewController.h
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "additionData.h"

@interface licenseKeyViewController : UIViewController
{
    additionData *_addData;
}
@property additionData *addData;
@property (weak, nonatomic) IBOutlet UITextField *tagField;
@property (weak, nonatomic) IBOutlet UITextField *keyField;
- (IBAction)next:(id)sender;
@end
