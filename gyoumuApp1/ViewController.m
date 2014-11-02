//
//  ViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/10/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *pwText;
- (IBAction)GuestBtn:(id)sender;

- (IBAction)loginBtn:(id)sender;
@end

@implementation ViewController/*
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

    //ボタンを押した際の処理条件を設定する
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([sender tag] == 1) {
        //Supporting Files内のjsonUser.txtを参照
        NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonUser" ofType:@"txt"];
        NSData *jsondata = [NSData dataWithContentsOfFile:path];
        NSDictionary *jsonDlc = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
        
        //キーが「０」の研究室を指定
        NSMutableArray *jsonArray1 = [jsonDlc objectForKey:@"0"];
        
        //研究室を指定するためのカウント変数
        int count = 0;
        //goto文の指定先
        prev:
        //ログイン判定処理 usernameとterminalIdで判定
    for(int i = 0; i < jsonArray1.count; i++) {
        if( ([self.userText.text isEqualToString:jsonArray1[i][@"username"]] == YES) && ([self.pwText.text  isEqualToString:jsonArray1[i][@"terminalId"]]) ) {
            
            //NSUserDefaultsを設定
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:jsonArray1[i] forKey:@"userData"];
            //NSMutableArray *test1 = [userDefaults objectForKey:@"userData"];
            //NSLog(@"%@", test1);
            
            //画面を遷移するYES
            return YES;
        }
        
                    }
        //現在jsonArray1が指す研究室に該当するユーザが存在しなかったら、かつcountの値が研究室数を超えてなかったら
        if (count != 2) {
        //次の研究室を参照するために増やす
        count++;
        
        jsonArray1 = [jsonDlc objectForKey:[NSString stringWithFormat:@"%d",count]];
            //NSLog(@"%@",jsonArray1);
            //ログイン判定のfor文へ
        goto prev;
        }
        // 一致しなかった場合のアラート処理
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"もう一度入力してください"
                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return NO;
    //一致しないので遷移しない
    }
    //ゲストユーザボタン処理
    if ([sender tag] == 2) {
        // do something here
        return YES;
    }
    return NO;
}

//ゲストユーザ遷移先での戻るボタンのメソッド
-(IBAction)returnMain:(UIStoryboardSegue *)sender
{
    
}
//- (IBAction)loginBtn:(id)sender {
//}
@end