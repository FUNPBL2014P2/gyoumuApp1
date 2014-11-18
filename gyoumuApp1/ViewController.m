//
//  ViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/10/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "ViewController.h"
#import "WebdbConnect.h"


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
    WebdbConnect *test1 = [[WebdbConnect alloc]initWithLabArray:@"1"];
    NSLog(@"%@", [[test1 labBadgeGet:@"09"] valueForKeyPath:@"terminalId"]);
    //Supporting Files内のjsonUser.txtを参照
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonUser" ofType:@"txt"];
    NSData *jsondata = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonDlc = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
    
    //キーが「０」の研究室を指定
    NSMutableArray *jsonArray1 = [jsonDlc objectForKey:@"lab"];
    
    NSLog(@"%@",jsonArray1[1]);
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
                [self addLogin2:@"05" badgeFlag:3];
                [self addLogin:@"01" badgeFlag:1];
                [self addLogin:@"06" badgeFlag:10];
                [self addLoginTime];
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

- (IBAction)BadgeOneResetBtn:(id)sender {
    
    NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
    
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    for (int i = 0; jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge01"]) {
            
            NSURL *url = [NSURL URLWithString:@"http://webdb.per.c.fun.ac.jp/sofline/add.php"];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"POST"];
            //パラメータを作成
            NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=0&option2=0&option3=%@&option4=%@&option5=%@", jsonArray[i][@"title"], jsonArray[i][@"terminalId"], jsonArray[i][@"option3"], jsonArray[i][@"option4"], jsonArray[i][@"option5"]];
            
            request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
            NSURLConnection *connection;
            connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            ///////////////////
            NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline/delete.php?data=/%@/%@",jsonArray[i][@"terminalId"], jsonArray[i][@"datetime"]];
            NSURL *urlDelete = [NSURL URLWithString:strURL];
            NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
            [deleteRequest setHTTPMethod:@"GET"];
            [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
            ///////////////////
            //削除したら抜ける
            break;
            
            
        }
    }
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"Reset" message:@"Resetしました"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    return ;
}

- (IBAction)BadgeFiveResetBtn:(id)sender {
    NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
    
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    for (int i = 0; jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge05"]) {
            
            NSURL *url = [NSURL URLWithString:@"http://webdb.per.c.fun.ac.jp/sofline/add.php"];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"POST"];
            //パラメータを作成
            NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=0&option2=0&option3=%@&option4=%@&option5=%@", jsonArray[i][@"title"], jsonArray[i][@"terminalId"], jsonArray[i][@"option3"], jsonArray[i][@"option4"], jsonArray[i][@"option5"]];
            
            request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
            NSURLConnection *connection;
            connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            ///////////////////
            NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline/delete.php?data=/%@/%@",jsonArray[i][@"terminalId"], jsonArray[i][@"datetime"]];
            NSURL *urlDelete = [NSURL URLWithString:strURL];
            NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
            [deleteRequest setHTTPMethod:@"GET"];
            [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
            ///////////////////
            //削除したら抜ける
            break;
            
            
        }
    }
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"Reset" message:@"Resetしました"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    return ;
}

- (IBAction)BadgeSixResetBtn:(id)sender {
    NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
    
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    for (int i = 0; jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge06"]) {
            
            NSURL *url = [NSURL URLWithString:@"http://webdb.per.c.fun.ac.jp/sofline/add.php"];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"POST"];
            //パラメータを作成
            NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=0&option2=0&option3=%@&option4=%@&option5=%@", jsonArray[i][@"title"], jsonArray[i][@"terminalId"], jsonArray[i][@"option3"], jsonArray[i][@"option4"], jsonArray[i][@"option5"]];
            
            request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
            NSURLConnection *connection;
            connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            ///////////////////
            NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline/delete.php?data=/%@/%@",jsonArray[i][@"terminalId"], jsonArray[i][@"datetime"]];
            NSURL *urlDelete = [NSURL URLWithString:strURL];
            NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
            [deleteRequest setHTTPMethod:@"GET"];
            [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
            ///////////////////
            //削除したら抜ける
            break;
            
            
        }
    }
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"Reset" message:@"Resetしました"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    return ;
}

-(void) addLoginTime {
    
    NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    
    
    for (int i = 0; jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"loginTime"]) {
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            [fmt setDateFormat:@"yyyy年MM月dd日 HH時mm分"];
            NSDate *nowGet = [[NSDate alloc]init];
            /////////////////////取得日時を送信する処理
            NSURL *url = [NSURL URLWithString:@"http://webdb.per.c.fun.ac.jp/sofline/add.php"];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"POST"];
            //パラメータを作成
            NSString *body = [NSString stringWithFormat:@"title=login&message=&latitude=&longitude=&terminalId=loginTime&option0=&option1=%@&option2=&option3=&option4=&option5=",[fmt stringFromDate:nowGet]];
            request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
            NSURLConnection *connection;
            connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            
            
            NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline/delete.php?data=/%@/%@",jsonArray[i][@"terminalId"], jsonArray[i][@"datetime"]];
            NSURL *urlDelete = [NSURL URLWithString:strURL];
            NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
            [deleteRequest setHTTPMethod:@"GET"];
            [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
            
            return ;
        }
    }
}

//ログイン日数用
-(void) addLogin:(NSString *)title badgeFlag:(int)flagCount
{
    //Viewall用
    
    NSString *subold;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/viewall.php",[userData valueForKeyPath:@"labCode"]];
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    
    
    int count = 0;
    NSString *time_old;
    NSString *time_new;;
    
    
    for (int i = 0; jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:[NSString stringWithFormat:@"badge%@",title]]) {
            if ( [jsonArray[i][@"option0"] isEqualToString:@"1"]) {
                return;
            }
            
            time_old  = jsonArray[i][@"option1"];
            
            count = [jsonArray[i][@"option2"] intValue];
            
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            [fmt setDateFormat:@"yyyy年MM月dd日 HH時mm分"];
            NSDate *nowGet = [[NSDate alloc]init];
            
            time_new = [fmt stringFromDate:nowGet];
            
            //日にちを取得
            NSString *sub = [NSString stringWithFormat:@"%@",time_old];
            
            if(sub.length == 0){
            subold= @"0000年00月00日";
            }else{
            subold = [time_old substringWithRange:NSMakeRange(8, 2)];
            }
            
            NSString *subnew = [time_new substringWithRange:NSMakeRange(8, 2)];
            
            //同じ日じゃなければcount++
            if(subold.length == 0){
                count= 1;
            }else if(![subold isEqualToString:subnew]) {
                count++;
               }
            
            
            
            
            if (count == flagCount) {
                /////////////////取得日時
                
                /////////////////////取得日時を送信する処理
                NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];

                NSURL *url = [NSURL URLWithString:urlList];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                [request setHTTPMethod:@"POST"];
                //パラメータを作成
                NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=1&option1=%@&option2=%@&option3=%@&option4=%@&option5=%@",title,jsonArray[i][@"terminalId"],time_new,[NSString stringWithFormat:@"%d",flagCount], jsonArray[i][@"option3"],jsonArray[i][@"option4"],jsonArray[i][@"option5"]];
                request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
                NSURLConnection *connection;
                connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                //////////////////
                NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],jsonArray[i][@"terminalId"], jsonArray[i][@"datetime"]];
                NSURL *urlDelete = [NSURL URLWithString:strURL];
                NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
                [deleteRequest setHTTPMethod:@"GET"];
                [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
                ///////////////////
                //削除したら抜ける
                
                //////////////////
                
                
                UIAlertView *alert =
                [[UIAlertView alloc] initWithTitle:@"バッジ取得" message:jsonArray[i][@"option3"]
                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return ;
            }
            
            else if (count < flagCount) {
                NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
                NSURL *url = [NSURL URLWithString:urlList];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                [request setHTTPMethod:@"POST"];
                //パラメータを作成
                NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=0&option1=%@&option2=%@&option3=%@&option4=%@&option5=%@",title,jsonArray[i][@"terminalId"],time_new,[NSString stringWithFormat:@"%d",count], jsonArray[i][@"option3"],jsonArray[i][@"option4"],jsonArray[i][@"option5"]];
                request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
                NSURLConnection *connection;
                connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                /////////////////////
                NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],jsonArray[i][@"terminalId"], jsonArray[i][@"datetime"]];
                NSURL *urlDelete = [NSURL URLWithString:strURL];
                NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
                [deleteRequest setHTTPMethod:@"GET"];
                [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
                ///////////////////
                //削除したら抜ける
                return ;
                /////////////////////
            }
        }
    }
}

//連続ログイン用

-(void) addLogin2:(NSString *)title badgeFlag:(int)flagCount
{
    
    NSString *subold;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/viewall.php",[userData valueForKeyPath:@"labCode"]];
    

    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    
    
    
    int count = 0;
    NSString *time_old;
    NSString *time_new;;
    
    for (int i = 0; jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:[NSString stringWithFormat:@"badge%@",title]]) {
            if ( [jsonArray[i][@"option0"] isEqualToString:@"1"]) {
                return;
            }
            
            time_old = jsonArray[i][@"option1"];
            count = [jsonArray[i][@"option2"] intValue];
            
            
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            [fmt setDateFormat:@"yyyy年MM月dd日 HH時mm分"];
            
            NSDate *nowGet = [[NSDate alloc]init];
            
            time_new = [fmt stringFromDate:nowGet];
            
            NSString *sub = [NSString stringWithFormat:@"%@",time_old];
            if(sub.length == 0){
                subold= @"0000年00月00日";
            }else{
                subold = [time_old substringWithRange:NSMakeRange(8, 2)];
            }

            
            NSString *subnew = [time_new substringWithRange:NSMakeRange(8, 2)];
            
            
            
            NSDate *resDate = [nowGet initWithTimeInterval:-1*24*60*60 sinceDate:nowGet];
            NSString *lastday= [fmt stringFromDate:resDate];
            
            NSString *last = [lastday substringWithRange:NSMakeRange(8, 2)];
            
            
            NSLog(@"%@",subnew);
            NSLog(@"%@",subold);
            NSLog(@"%@",last);
            
            
          
            
            if([subold isEqualToString:last]) {
                count+= 1;
            }else if([subnew isEqualToString: subold]){
                
            }else{
                count = 1;
            }
            
            NSLog(@"%d",count);
            
            if (count == flagCount) {
                /////////////////取得日時
                
                /////////////////////取得日時を送信する処理
                NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
                
                NSURL *url = [NSURL URLWithString:urlList];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                [request setHTTPMethod:@"POST"];
                //パラメータを作成
                NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=1&option1=%@&option2=%@&option3=%@&option4=%@&option5=%@",title,jsonArray[i][@"terminalId"],time_new,[NSString stringWithFormat:@"%d",flagCount], jsonArray[i][@"option3"],jsonArray[i][@"option4"],jsonArray[i][@"option5"]];
                request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
                NSURLConnection *connection;
                connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                //////////////////
                NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],jsonArray[i][@"terminalId"], jsonArray[i][@"datetime"]];
                NSURL *urlDelete = [NSURL URLWithString:strURL];
                NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
                [deleteRequest setHTTPMethod:@"GET"];
                [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
                ///////////////////
                //削除したら抜ける
                
                //////////////////
                
                
                UIAlertView *alert =
                [[UIAlertView alloc] initWithTitle:@"バッジ取得" message:jsonArray[i][@"option3"]
                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return ;
            }
            
            else if (count < flagCount) {
                NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
                NSURL *url = [NSURL URLWithString:urlList];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                [request setHTTPMethod:@"POST"];
                //パラメータを作成
                NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=0&option1=%@&option2=%@&option3=%@&option4=%@&option5=%@",title,jsonArray[i][@"terminalId"],time_new,[NSString stringWithFormat:@"%d",count], jsonArray[i][@"option3"],jsonArray[i][@"option4"],jsonArray[i][@"option5"]];
                request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
                NSURLConnection *connection;
                connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                /////////////////////
                NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],jsonArray[i][@"terminalId"], jsonArray[i][@"datetime"]];
                NSURL *urlDelete = [NSURL URLWithString:strURL];
                NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
                [deleteRequest setHTTPMethod:@"GET"];
                [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
                ///////////////////
                //削除したら抜ける
                return ;
                /////////////////////
            }
        }
    }
}

@end