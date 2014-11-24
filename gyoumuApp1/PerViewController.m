//
//  PerViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/10/16.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "PerViewController.h"
#import "WebdbConnect.h"

@interface PerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labName;
@end

@implementation PerViewController

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
    NSString *str1 = @"Login User:";
    /*
     { //例
     0"datetime": "20141002-133706",
     1"title": "Parallels Desktop 9 for Mac",
     2"message": "安藤",
     3"latitude": "0",
     4"longitude": "0",
     5"terminalId": "MA-015",
     6"username": "MA-015",
     7"option0": "箱",
     8"option1": "",
     9"option2": "",
     10"option3": "",
     11"option4": "",
     12"option5": "",
     13"option6": "",
     14"option7": "",
     15"option8": "",
     16"option9": ""
    }
     */ //ログインユーザのそれぞれの値を取り出せます
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    //Supporting Files内のjsonUser.txtを参照
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonUser" ofType:@"txt"];
    NSData *jsondata = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonDlc = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
    NSMutableArray *jsonArray1 = [jsonDlc objectForKey:@"lab"];
    
    NSString *labName = [NSString stringWithFormat:@"%@",[userData valueForKeyPath:@"labCode"]];
    int value1 = [labName intValue];
    NSLog(@"現在%@のデータを参照しています", [userData valueForKeyPath:@"name"]);
    NSLog(@"研究室コード:%@,%@", [userData valueForKeyPath:@"labCode"],jsonArray1[value1-1]);
    NSString *val = [str1 stringByAppendingString:[userData valueForKeyPath:@"name"]];
    self.labName.text = val;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
         // Dispose of any resources that can be recreated.
}

-(void) evaluateRecieveCheck:(int) flagCount :(NSString *) badgeTitle
{
    //Viewall用
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    
    
    //NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/viewall.php",[userData valueForKeyPath:@"labCode"]];
    
    
    
    WebdbConnect *myLab = [[WebdbConnect alloc] initWithLabArray:[userData valueForKeyPath:@"labCode"]];
    
    
    
    NSObject *jsonArray = [myLab labBadgeGet:badgeTitle];
    
    
    
    if ( [[jsonArray valueForKeyPath:@"option0"] isEqualToString:@"1"]) {
        
        return;
        
    }
    int count;
    //int count = [[myLab labEvaluateGet]valueForKeyPath:@"option3"] intValue];
    
    
    
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
        
        NSString *body =[NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=1&option1=%@&option2=%@&option3=%@&option4=%@&option5=%@",[jsonArray valueForKeyPath:@"title"],[jsonArray valueForKeyPath:@"terminalId"],[fmt stringFromDate:nowGet],[NSString stringWithFormat:@"%d",flagCount], [jsonArray valueForKeyPath:@"option3"],[jsonArray valueForKeyPath:@"option4"],[jsonArray valueForKeyPath:@"option5"]];
        
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
        
        //削除したら抜ける
        
        
        
        //////////////////
        
        
        
        
        
        UIAlertView *alert =
        
        [[UIAlertView alloc] initWithTitle:@"バッジ取得" message:[jsonArray valueForKeyPath:@"option3"]
         
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
        
        NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=0&option1=&option2=%d&option3=%@&option4=%@&option5=%@",[jsonArray valueForKeyPath:@"title"],[jsonArray valueForKeyPath:@"terminalId"],count,[jsonArray valueForKeyPath:@"option3"],[jsonArray valueForKeyPath:@"option4"],[jsonArray valueForKeyPath:@"option5"]];
        
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURLConnection *connection;
        
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        /////////////////////
        
        NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],[jsonArray valueForKeyPath:@"terminalId"], [jsonArray valueForKeyPath:@"datetime"]];
        
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
