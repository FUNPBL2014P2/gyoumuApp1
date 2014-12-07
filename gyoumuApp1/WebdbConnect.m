//
//  WebdbConnect.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/17.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "WebdbConnect.h"

@implementation WebdbConnect
{
    NSArray *_labArray;
}

-(void)setLabArray:(NSString *)labCode
{
    NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/viewall.php",labCode];
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];

    _labArray = jsonArray;
}

-(NSArray *)labArray
{
    return _labArray;
}

//badgeのタイトルと一致する情報を返す
-(NSObject *)labBadgeGet:(NSString *)badgeTitle
{
    for (int i = 0; i < _labArray.count; i++) {
        if ([_labArray[i][@"terminalId"] isEqualToString:[NSString stringWithFormat:@"badge%@",badgeTitle]]) {
            return _labArray[i];
        }
    }
    return nil;
}

-(NSObject *)labEvaluateGet
{
    for (int i = 0; i < _labArray.count; i++) {
        if ([_labArray[i][@"terminalId"] isEqualToString:@"Evaluate"]) {
            return _labArray[i];
        }
    }
    return nil;
}

-(NSMutableArray *)labMasterGet
{
    NSMutableArray* masterArray = [[NSMutableArray alloc]init];
    
        for (int i = 0; i < _labArray.count; i++) {
                if ([_labArray[i][@"terminalId"] isEqualToString:@"マスタ"]) {
                    [masterArray addObject:_labArray[i]];
                }
        }
        return masterArray;
}

-(NSMutableArray *)labBadgeAllGet
{
    NSMutableArray* badgeArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _labArray.count; i++) {
        NSString *terminal_badge = [_labArray[i][@"terminalId"] substringWithRange:NSMakeRange(0, 3)];
        if ([terminal_badge isEqualToString:@"bad"]) {
            [badgeArray addObject:_labArray[i]];
        }
    }
    return badgeArray;
}


-(id)initWithLabArray:(NSString *)labCode
{
    self = [super init];
    if (self) {
        NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/viewall.php",labCode];
        
        NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
        NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
        NSArray *jsonArray = [jsonDic objectForKey:@"data"];
        _labArray = jsonArray;
    }
    return self;
}

-(NSMutableArray *)labLicenseGet
{
    NSMutableArray* licenseArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _labArray.count; i++) {
        if ([_labArray[i][@"terminalId"] isEqualToString:@"ライセンス"]) {
            [licenseArray addObject:_labArray[i]];
        }
    }
    return licenseArray;
}


-(NSMutableArray *)labLicenseCodeGet:(NSString *)code
{
    NSMutableArray* licenseArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _labArray.count; i++) {
        if ([_labArray[i][@"option7"] isEqualToString:code]) {
            [licenseArray addObject:_labArray[i]];
        }
    }
    return licenseArray;
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
