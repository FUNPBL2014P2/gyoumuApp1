//
//  guestViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/10/23.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "guestViewController.h"

@interface guestViewController ()

@end

@implementation guestViewController
//new
@synthesize backRectBtn;

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
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //[userDefaults setObject:@"guest" forKey:@"userData"];
    //NSLog(@"現在%@なのでユーザデータは保持されていません", [userDefaults stringForKey:@"userData"]);

    // Do any additional setup after loading the view.
    //new
    double btnBorderRectPoint = 2.0;
    //new
    backRectBtn.layer.cornerRadius = 10;
    [[backRectBtn layer] setBorderColor:[[UIColor blackColor]CGColor]];
    [[backRectBtn layer] setBorderWidth:btnBorderRectPoint];

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
