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
            NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=0&option2=4&option3=%@&option4=%@&option5=%@", jsonArray[i][@"title"], jsonArray[i][@"terminalId"], jsonArray[i][@"option3"], jsonArray[i][@"option4"], jsonArray[i][@"option5"]];
            
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
    
    /////////////////////
        //////////////////
    
    ////////////////
    
    

}

-(void) addLicense:(NSString *)title badgeFlag:(int)flagCount
{
    //Viewall用
    NSString *urlList = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
    
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
                NSURL *url = [NSURL URLWithString:@"http://webdb.per.c.fun.ac.jp/sofline/add.php"];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                [request setHTTPMethod:@"POST"];
                //パラメータを作成
                NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=1&option1=%@&option2=%@&option3=%@&option4=%@&option5=%@",title,jsonArray[i][@"terminalId"],[fmt stringFromDate:nowGet],[NSString stringWithFormat:@"%d",flagCount], jsonArray[i][@"option3"],jsonArray[i][@"option4"],jsonArray[i][@"option5"]];
                request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
                NSURLConnection *connection;
                connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                //////////////////
                NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline/delete.php?data=/%@/%@",jsonArray[i][@"terminalId"], jsonArray[i][@"datetime"]];
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
                NSURL *url = [NSURL URLWithString:@"http://webdb.per.c.fun.ac.jp/sofline/add.php"];
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                [request setHTTPMethod:@"POST"];
                //パラメータを作成
                NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=0&option1=&option2=%@&option3=%@&option4=%@&option5=%@",title,jsonArray[i][@"terminalId"],[NSString stringWithFormat:@"%d",count], jsonArray[i][@"option3"],jsonArray[i][@"option4"],jsonArray[i][@"option5"]];
                request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
                NSURLConnection *connection;
                connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                /////////////////////
                NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline/delete.php?data=/%@/%@",jsonArray[i][@"terminalId"], jsonArray[i][@"datetime"]];
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
