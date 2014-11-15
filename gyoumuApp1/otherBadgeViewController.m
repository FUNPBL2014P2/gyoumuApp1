//
//  otherBadgeViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "otherBadgeViewController.h"
#import "BadgeDetailViewController.h"

@interface otherBadgeViewController ()

@end

@implementation otherBadgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goDetail:(id)sender {
    
    //バッジ詳細画面のStoryboard IDは"badgeDetail"です
    BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
    sendView.receiveBadgeName = @"";//バッジのパスを入力してください
    [self presentViewController:sendView animated:NO completion:nil];
    
}
@end
