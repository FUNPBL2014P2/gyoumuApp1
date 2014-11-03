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
//バッジ09カウンタを04から05へ変更
- (IBAction)licenseAddBtn:(UIButton *)sender {
    //badge09の処理
    int frag9 = 0;
    int obtain9 = 0;
    
    NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/list.php";
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    //jsonArray = [jsonArray objectForKey:@"data"];
    //NSLog(@"%@", [jsonArray objectForKey:@"data"]);
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    //新しいものが0から格納されていくので、最後尾から検索する
    for (int i = 0; i < (int)jsonArray.count-1; i++) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge09"]) {
            NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline/view.php?data=%@",jsonArray[i][@"path"]];
            NSURL *urlView = [NSURL URLWithString:strURL];
            NSMutableURLRequest *viewRequest = [NSMutableURLRequest requestWithURL:urlView];
            [viewRequest setHTTPMethod:@"GET"];
            [NSURLConnection sendSynchronousRequest:viewRequest returningResponse:nil error:nil];
            ///////////////////
            
            NSData *viewList = [NSURLConnection sendSynchronousRequest:viewRequest returningResponse:nil error:nil];
            NSDictionary *viewDic = [NSJSONSerialization JSONObjectWithData:viewList options:0 error:nil];
            //NSLog(@"%@", viewDic[@"option2"]);
            frag9 = [viewDic[@"option2"] intValue];
            //NSLog(@"%d", frag);
            
            //fragの条件が変わることを行ったかをif文に通す？
            //if(){}
            
            frag9 +=  +1;
            
            if(frag9 >= 5){
                obtain9 = 1;
            }
            
            
            NSURL *url = [NSURL URLWithString:@"http://webdb.per.c.fun.ac.jp/sofline/add.php"];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"POST"];
            //パラメータを作成
            
            NSString *body = [NSString stringWithFormat:@"title=09&message=&latitude=&longitude=&terminalId=badge09&option0="];
            
            NSString *aString = [body stringByAppendingString:[NSString stringWithFormat:@"%d",obtain9]];
            NSString *bString = [aString stringByAppendingString:[NSString stringWithFormat:@"&option2="]];
            NSString *cString = [bString stringByAppendingString:[NSString stringWithFormat:@"%d",frag9]];
            
            request.HTTPBody = [cString dataUsingEncoding:NSUTF8StringEncoding];
            NSURLConnection *connection;
            connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            //NSLog(@"%@",aString);
            
        }
        break;
    }
    
    //新しいものが0から格納されていくので、最後尾から検索する
    for (int i = (int)jsonArray.count-1; i >= 0; i--) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge09"]) {
            NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline/delete.php?data=%@",jsonArray[i][@"path"]];
            NSURL *urlDelete = [NSURL URLWithString:strURL];
            NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
            [deleteRequest setHTTPMethod:@"GET"];
            [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
            ///////////////////
            //削除したら抜ける
            break;
            
            
        }
    }
}

//バッジ09リセット処理
- (IBAction)BadgeNineResetBtn:(id)sender {
    /////////////////////
    NSURL *url = [NSURL URLWithString:@"http://webdb.per.c.fun.ac.jp/sofline/add.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    //パラメータを作成
    NSString *body = [NSString stringWithFormat:@"title=09&message=&latitude=&longitude=&terminalId=badge09&option0=0&option2=4"];
    
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLConnection *connection;
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //////////////////
    
    ////////////////
    
    //古い方のbadge09の削除を行う
    NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/list.php";
    
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    //jsonArray = [jsonArray objectForKey:@"data"];
    //NSLog(@"%@", [jsonArray objectForKey:@"data"]);
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];
    //新しいものが0から格納されていくので、最後尾から検索する
    for (int i = (int)jsonArray.count-1; i >= 0; i--) {
        if ([jsonArray[i][@"terminalId"] isEqualToString:@"badge09"]) {
            NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline/delete.php?data=%@",jsonArray[i][@"path"]];
            NSURL *urlDelete = [NSURL URLWithString:strURL];
            NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
            [deleteRequest setHTTPMethod:@"GET"];
            [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
            ///////////////////
            //削除したら抜ける
            break;
            
        }
    }
    

}
@end
