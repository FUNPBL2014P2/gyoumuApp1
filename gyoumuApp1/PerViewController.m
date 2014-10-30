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
    NSString *str1 = @"Login User:";
    /*
     { //例
     0"datetime": "20141002-133706",
     1"title": "Parallels Desktop 9 for Mac",
     2"message": "安藤",
     3"latitude": "0",
     4"longitude": "0",
     5"terminalId": "MA-015",
     6"username": "MA-015",
     7"option0": "箱",
     8"option1": "",
     9"option2": "",
     10"option3": "",
     11"option4": "",
     12"option5": "",
     13"option6": "",
     14"option7": "",
     15"option8": "",
     16"option9": ""
    }
     */ //ログインユーザのそれぞれの値を取り出せます
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    

    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    NSLog(@"現在%@のデータを参照しています", [userData valueForKeyPath:@"name"]);
    NSLog(@"研究室コード:%@", [userData valueForKeyPath:@"labCode"]);
    NSString *val = [str1 stringByAppendingString:[userData valueForKeyPath:@"name"]];
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
