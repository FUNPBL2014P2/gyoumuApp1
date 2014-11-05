//
//  BadgeDetailViewController.h
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/03.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeDetailViewController : UIViewController
{
    NSString *receiveBadgeName;
}
@property (weak, nonatomic) IBOutlet UIImageView *detailBackground;
@property (copy) NSString *receiveBadgeName;
@property (weak, nonatomic) IBOutlet UILabel *badgeExpLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeConditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeGetTimeLabel;

@end
