//
//  PerViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/10/16.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "PerViewController.h"

@interface PerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labName;
@end

@implementation PerViewController

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
    //ログインしたユーザ名を引き継いだのを渡しています .hファイルを参照
    NSString *str1 = @"Login User:";
    NSString *val = [str1 stringByAppendingString:self.recieveLabName];
    self.labName.text = val;
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
