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
- (IBAction)GuestBtn:(id)sender;

- (IBAction)loginBtn:(id)sender;
@end

@implementation ViewController/*{
    //引き継がせたい変数の方を設定
    NSArray *sendPerArray;
}
                               */
//selfがめんどくさいので
@synthesize loginBtn;

- (void)viewDidLoad
{
    //ボタンの枠の太字を設定
    double btnBorderRectPoint = 2.0;
    [super viewDidLoad];
   	// Do any additional setup after loading the view, typically from a nib.
    //ボタンの背景の角をラウンドに
    loginBtn.layer.cornerRadius = 10;
    //枠の色
    [[loginBtn layer] setBorderColor:[[UIColor blackColor]CGColor]];
    //枠の太さ
    [[loginBtn layer] setBorderWidth:btnBorderRectPoint];

       }

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GuestBtn:(id)sender {
}

- (IBAction)loginBtn:(id)sender {
    }

//画面が遷移した際の関数　ここで引き継ぎしが行われる
/*
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"next"] ) {
        PerViewController *PerViewController = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数recivePerArrayに値を渡している
        PerViewController.receivePerArray = sendPerArray;
    }
}
*/
    //ボタンを押した際の処理条件を設定する
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([sender tag] == 1) {
        // do something here
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
            
            //NSUserDefaultsを設定
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:jsonArrayPersonal forKey:@"userData"];
            
            //NSLog(@"%@", [userDefaults stringForKey:@"userpath"]);
            //値渡しするsendArrayにユーザ情報を代入
            //sendPerArray = jsonArrayPersonal;
                        //画面を遷移するYES
            return YES;
        }
            }
       
        
        // 生成と同時に各種設定も完了させる
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"もう一度入力してください"
                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return NO;
    //一致しないので遷移しない
    }
    if ([sender tag] == 2) {
        // do something here
        return YES;
    }
    return NO;
}

-(IBAction)returnMain:(UIStoryboardSegue *)sender
{
    
}
//- (IBAction)loginBtn:(id)sender {
//}
@end