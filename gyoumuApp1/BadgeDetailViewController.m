//
//  BadgeDetailViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/03.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "BadgeDetailViewController.h"

@interface BadgeDetailViewController ()

@end


@implementation BadgeDetailViewController

@synthesize receiveBadgeName;
@synthesize badgeExpLabel;
@synthesize badgeConditionLabel;
@synthesize badgeGetTimeLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self.view sendSubviewToBack:_detailBackground];
    NSLog(@"%@", receiveBadgeName);
    badgeExpLabel.text = @"ライセンスを５回登録したということでこれからライセンス管理を頑張って欲しいという気持ちが込められたバッジ。気を抜くんじゃないぞ！";
    badgeConditionLabel.text = @"ライセンスを何でもいいから５回登録だ！";
    badgeGetTimeLabel.text = @"(例) 2014年11月5日 2時50分";
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
