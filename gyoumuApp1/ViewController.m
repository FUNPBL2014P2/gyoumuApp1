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
    NSArray *sendPerArray;
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

//画面が遷移した際の関数　ここで引き継ぎしが行われる
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"next"] ) {
        PerViewController *PerViewController = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数recivePerArrayに値を渡している
        PerViewController.receivePerArray = sendPerArray;
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
            //個人のユーザ情報を取得するための処理
            NSString *orignPersonal = @"http://webdb.per.c.fun.ac.jp/sofline/view.php?data=";
            NSString *urlPersonal = [NSString stringWithFormat:@"%@%@",orignPersonal,jsonArray[i][@"path"]];
            
            
            NSURLRequest *requestPersonal = [NSURLRequest requestWithURL:[NSURL URLWithString:urlPersonal]];
            NSData *jsonDataPersonal = [NSURLConnection sendSynchronousRequest:requestPersonal returningResponse:nil error:nil];
            NSArray *jsonArrayPersonal = [NSJSONSerialization JSONObjectWithData:jsonDataPersonal options:NSJSONReadingAllowFragments error:nil];
            //値渡しするsendArrayにユーザ情報を代入
            sendPerArray = jsonArrayPersonal;
                        //画面を遷移するYES
            return YES;
        }
            }
    //一致しないので遷移しない
    return NO;
}
@end