//
//  otherLicenseViewController3.h
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/22.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface otherLicenseViewController3 : UIViewController

- (IBAction)communeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *communeBtn;
@property (weak, nonatomic) IBOutlet UILabel *receiveNumber;
@property (weak, nonatomic) IBOutlet UILabel *communeTime;
@property (weak, nonatomic) IBOutlet UIImageView *communeImage;
@property (weak, nonatomic) IBOutlet UIImageView *receiveImage;
@end
