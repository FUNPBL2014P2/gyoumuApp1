//
//  licenseAddViewController.m
//  gyoumuApp1
//
//  Created by FUNAICT201312 on 2014/11/02.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "licenseAddViewController.h"

@interface licenseAddViewController ()

@end

@implementation licenseAddViewController

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
//登録フラグを１つ増やす
- (IBAction)licenseAddBtn:(UIButton *)sender {
    
    /*
     NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
     
     NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
     NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
     NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
     NSArray *jsonArray = [jsonDic objectForKey:@"data"];
     int div = 0;
     
     for (int i = 0; jsonArray.count; i++) {
     if ([jsonArray[i][@"terminalId"] isEqualToString:[NSString stringWithFormat:@"badge03"]]) {
     div = [jsonArray[i][@"option2"] intValue] + 1;
     NSLog(@"%d",div);
     return;
     }
     }
     */
    
    
    [self addLicense:@"03" badgeFlag:1];
    [self addLicense:@"09" badgeFlag:5];
    [self addLicense:@"10" badgeFlag:10];
    
    
}

//バッジ09リセット処理
- (IBAction)BadgeNineResetBtn:(id)sender {
    
    //Viewall用
    NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
    
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    
    for (int i = 0; jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge09"]) {
            
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

- (IBAction)BadgeThreeResetBtn:(id)sender {
    //Viewall用
    NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
    
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    for (int i = 0; jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge03"]) {
            
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

- (IBAction)BadgeTenResetBtn:(id)sender {
    //Viewall用
    NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
    
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    for (int i = 0; jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge10"]) {
            
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

- (IBAction)BadgeFourteenResetBtn:(id)sender {
    //Viewall用
    NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
    
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    for (int i = 0; jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge14"]) {
            
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

- (IBAction)BadgeFifteenResetBtn:(id)sender {
    //Viewall用
    NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
    
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    for (int i = 0; jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge15"]) {
            
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

- (IBAction)BadgeSixteenResetBtn:(id)sender {
    //Viewall用
    NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
    
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    for (int i = 0; jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge16"]) {
            
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



-(void) addLicense:(NSString *)title badgeFlag:(int)flagCount
{
    //Viewall用
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/viewall.php",[userData valueForKeyPath:@"labCode"]];
    

    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    int count = 0;
    for (int i = 0; jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:[NSString stringWithFormat:@"badge%@",title]]) {
            if ( [jsonArray[i][@"option0"] isEqualToString:@"1"]) {
                return;
            }
            count = [jsonArray[i][@"option2"] intValue] + 1;
            
            if (count == flagCount) {
                /////////////////取得日時
                NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
                [fmt setDateFormat:@"yyyy年MM月dd日 HH時mm分"];
                NSDate *nowGet = [[NSDate alloc]init];
                /////////////////////取得日時を送信する処理
                NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
                
                NSURL *url = [NSURL URLWithString:urlList];

                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                [request setHTTPMethod:@"POST"];
                //パラメータを作成
                NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=1&option1=%@&option2=%@&option3=%@&option4=%@&option5=%@",title,jsonArray[i][@"terminalId"],[fmt stringFromDate:nowGet],[NSString stringWithFormat:@"%d",flagCount], jsonArray[i][@"option3"],jsonArray[i][@"option4"],jsonArray[i][@"option5"]];
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
                [self badgeOwnGet];
                return ;
            }
            
            else if (count < flagCount) {
                NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
                
                NSURL *url = [NSURL URLWithString:urlList];

                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                [request setHTTPMethod:@"POST"];
                //パラメータを作成
                NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=0&option1=&option2=%@&option3=%@&option4=%@&option5=%@",title,jsonArray[i][@"terminalId"],[NSString stringWithFormat:@"%d",count], jsonArray[i][@"option3"],jsonArray[i][@"option4"],jsonArray[i][@"option5"]];
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

//badge14~16のフラグを満たしているかどうか判定するメソッド
-(void) badgeOwnGet
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/viewall.php",[userData valueForKeyPath:@"labCode"]];

    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    //NSMutableArray *badgeArray = [NSMutableArray array];
    
    for (int i = 0; i < jsonArray.count; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge14"]) {
            [self badgeOwnCheck:jsonArray[i] badgeFlag:5];
        }
        else if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge15"]) {
            [self badgeOwnCheck:jsonArray[i] badgeFlag:10];
            
        }
        else if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge16"]) {
            [self badgeOwnCheck:jsonArray[i] badgeFlag:15];
        }
        
    }
    
    return;
}


//badgeOwnGetにおいてaddとdeleteを処理するメソッド
-(void) badgeOwnCheck:(id)badgeArrayobject badgeFlag:(int)flagCount
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];

    int count = 0;
    
    if ( [badgeArrayobject[@"option0"] isEqualToString:@"1"]) {
        return;
    }
    count = [badgeArrayobject[@"option2"] intValue] + 1;
    
    if (count == flagCount) {
        /////////////////取得日時
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        [fmt setDateFormat:@"yyyy年MM月dd日 HH時mm分"];
        NSDate *nowGet = [[NSDate alloc]init];
        /////////////////////取得日時を送信する処理
        NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
        
        NSURL *url = [NSURL URLWithString:urlList];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        //パラメータを作成
        NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=1&option1=%@&option2=%@&option3=%@&option4=%@&option5=%@",badgeArrayobject[@"title"],badgeArrayobject[@"terminalId"],[fmt stringFromDate:nowGet],[NSString stringWithFormat:@"%d",flagCount], badgeArrayobject[@"option3"],badgeArrayobject[@"option4"],badgeArrayobject[@"option5"]];
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSURLConnection *connection;
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        //////////////////
        NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],badgeArrayobject[@"terminalId"], badgeArrayobject[@"datetime"]];
        NSURL *urlDelete = [NSURL URLWithString:strURL];
        NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
        [deleteRequest setHTTPMethod:@"GET"];
        [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
        ///////////////////
        //削除したら抜ける
        
        //////////////////
        
        /*/Users/Oden/Documents/git_gyoumu/gyoumuApp1/gyoumuApp1/AppDelegate.m
         UIAlertView *alert =
         [[UIAlertView alloc] initWithTitle:@"バッジ取得" message:badgeArrayobject[@"option3"]
         delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
         */
        return ;
    }
    
    else if (count < flagCount) {
        NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
        
        NSURL *url = [NSURL URLWithString:urlList];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        //パラメータを作成
        NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=0&option1=&option2=%@&option3=%@&option4=%@&option5=%@",badgeArrayobject[@"title"],badgeArrayobject[@"terminalId"],[NSString stringWithFormat:@"%d",count], badgeArrayobject[@"option3"],badgeArrayobject[@"option4"],badgeArrayobject[@"option5"]];
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSURLConnection *connection;
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        /////////////////////
        NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],badgeArrayobject[@"terminalId"], badgeArrayobject[@"datetime"]];
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


@end
