//
//  settingViewController.m
//  gyoumuApp1
//
//  Created by FUNAICT201312 on 2014/11/25.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "settingViewController.h"
#import "WebdbConnect.h"

@interface settingViewController ()

@end

@implementation settingViewController

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

- (IBAction)allResetBtn:(id)sender {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    
    WebdbConnect *myLab = [[WebdbConnect alloc] initWithLabArray:[userData valueForKeyPath:@"labCode"]];
    
    NSObject *jsonArray =[myLab labEvaluateGet];
    NSMutableArray *badgeArray = [[NSMutableArray alloc]init];
    badgeArray = [myLab labBadgeAllGet];
    
    NSLog(@"%@",badgeArray[1]);
    
    for(int i = 0 ; i < badgeArray.count ; i++){
        
        
        /////////////////////取得日時を送信する処理
        
        NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
        
        NSURL *url = [NSURL URLWithString:urlList];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"POST"];
        
        //パラメータを作成
        
        NSString *body =[NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=0&option1=&option2=0&option3=%@&option4=%@&option5=%@",[badgeArray[i] valueForKeyPath:@"title"],[badgeArray[i] valueForKeyPath:@"terminalId"], [badgeArray[i] valueForKeyPath:@"option3"],[badgeArray[i] valueForKeyPath:@"option4"],[badgeArray[i] valueForKeyPath:@"option5"]];
        
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURLConnection *connection;
        
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        //////////////////
        
        NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],[badgeArray[i] valueForKeyPath:@"terminalId"], [badgeArray[i] valueForKeyPath:@"datetime"]];
        
        NSURL *urlDelete = [NSURL URLWithString:strURL];
        
        NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
        
        [deleteRequest setHTTPMethod:@"GET"];
        
        [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
        
    }
    
    ///////////////////
    
    /////////////////////取得日時を送信する処理
    
    NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
    
    NSURL *url = [NSURL URLWithString:urlList];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    //パラメータを作成
    
    NSString *body =[NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=&option1=&option2=0&option3=0&option4=&option5=",[jsonArray valueForKeyPath:@"title"],[jsonArray valueForKeyPath:@"terminalId"]];
    
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLConnection *connection;
    
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //////////////////
    
    NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],[jsonArray valueForKeyPath:@"terminalId"], [jsonArray valueForKeyPath:@"datetime"]];
    
    NSURL *urlDelete = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
    
    [deleteRequest setHTTPMethod:@"GET"];
    
    [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
    
    ///////////////////
    
}
@end
