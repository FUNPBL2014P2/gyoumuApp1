//
//  otherBadgeDetailViewController.h
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/19.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface otherBadgeDetailViewController : UIViewController
{
    NSString *receiveBadgeName;
}
@property (weak, nonatomic) IBOutlet UIImageView *detailBackground;
@property (copy) NSString *receiveBadgeName;
@property (weak, nonatomic) IBOutlet UILabel *badgeExpLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeConditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeGetTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *badgeImage;


@end
