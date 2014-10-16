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
    NSString *orign = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
    NSString *url = [NSString stringWithFormat:@"%@",orign];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonDlc = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    //jsonArrayにデータを格納
    NSArray *jsonArray = [jsonDlc objectForKey:@"data"];

    // Do any additional setup after loading the view.
    //ログインしたユーザ名を引き継いだのを渡しています .hファイルを参照
    NSString *str1 = @"Login User:";
    /* "datetime": "20141002-133706",
    "title"
    "message"
    "latitude"
     "longitude"
    "terminalId"
    "username"
    "option0"*/ //ログインユーザのそれぞれの値を取り出せます
    NSString *val = [str1 stringByAppendingString:jsonArray[_receiveUser][@"message"]];
    NSLog(@"%d", _receiveUser);
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
