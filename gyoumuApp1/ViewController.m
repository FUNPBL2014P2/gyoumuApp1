//
//  ViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/10/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "ViewController.h"
#import "PerViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *pwText;

- (IBAction)loginBtn:(id)sender;
@end

@implementation ViewController{
    //引き継がせたい変数の方を設定
    NSString *sendLabName;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   	// Do any additional setup after loading the view, typically from a nib.
    }

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtn:(id)sender {
    }

- (IBAction)nextView:(id)sender {
    [self performSegueWithIdentifier:@"next" sender:self];
}

//画面が遷移した際の関数　ここで引き継ぎしが行われる
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"next"] ) {
        PerViewController *PerViewController = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数recieveLabNameに値を渡している
        PerViewController.recieveLabName = sendLabName;
    }
}

    //ボタンを押した際の処理条件を設定する
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    //全体データを取得する処理
    NSString *orign = @"http://webdb.per.c.fun.ac.jp/sofline/list.php";
    NSString *url = [NSString stringWithFormat:@"%@",orign];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonDlc = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    //jsonArrayにデータを格納
    NSArray *jsonArray = [jsonDlc objectForKey:@"data"];
    
    for(int i = 0; i < jsonArray.count; i++) {
        if( ([self.userText.text isEqualToString:jsonArray[i][@"username"]] == YES) && ([self.pwText.text  isEqualToString:jsonArray[i][@"terminalId"]]) ) {
            //引き継がせたい文字列を代入
            sendLabName = jsonArray[i][@"username"];
            //画面を遷移するYES
            return YES;
        }
            }
    //一致しないので遷移しない
    return NO;
}
@end