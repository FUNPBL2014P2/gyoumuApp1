//
//  BadgeViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/10/31.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "BadgeViewController.h"

//値渡しのためのimport
#import "BadgeDetailViewController.h"

@interface BadgeViewController () {
    NSString *sendBadgeName;
    NSMutableArray *flagArray;
}

@end


@implementation BadgeViewController

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
    [self actionizeBadge];
        NSLog(@"ログインユーザの研究室バッジ一覧にて閲覧中");
    // Do any additional setup after loading the view.
    //UIImage *backgroundImage  = [UIImage imageNamed:@"background.jpg"];
    //self.view.layer.contents = (__bridge id)((backgroundImage.CGImage));
    /*
    
    UIImageView *background = [[UIImageView alloc]initWithImage:backgroundImage];
    background.frame = CGRectMake(0, 0,  self.view.frame.size.width,  self.view.frame.size.height);
    [self.view addSubview:background];
     */
    [self.view sendSubviewToBack:_backgroundView];
    
    /*バッジの配置*/
    /*
    self.badge1.contentMode = UIViewContentModeScaleAspectFill;
    self.badge1.image = [UIImage imageNamed:@"badge1.gif"];
    */
    
    self.badge = [[NSMutableArray alloc] initWithObjects:self.badge1,self.badge2,self.badge3,self.badge4,self.badge5,self.badge6,self.badge7,self.badge8,self.badge9,self.badge10,self.badge11,self.badge12,self.badge13,self.badge14,self.badge15,self.badge16,nil];
    [self badgeOwnGet];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //全体データを取得する処理
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    NSString *url = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/viewall.php",[userData valueForKeyPath:@"labCode"]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonDlc = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    //jsonArrayにデータを格納
    NSArray *jsonArray = [jsonDlc objectForKey:@"data"];
    flagArray = [NSMutableArray array];
    NSRange searchResult;
    for(int i = 0; i < jsonArray.count; i++){
        searchResult = [jsonArray[i][@"username"] rangeOfString:@"badge"];
        if (searchResult.location != NSNotFound) {
            [flagArray addObject:jsonArray[i]];
        }
    }
        //バッジナンバー"title"でソートする
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"title" ascending:YES];
    NSArray *sortArray = [NSArray arrayWithObjects:sort, nil];
    flagArray = (NSMutableArray *)[flagArray sortedArrayUsingDescriptors:sortArray];

       for(int i = 0; i < flagArray.count; i++) {
            if([flagArray[i][@"option0"] isEqualToString:@"1"]){
                UIImageView *badgeID = [_badge objectAtIndex:i];
                badgeID.contentMode = UIViewContentModeScaleAspectFill;
                badgeID.image = (i<9)? [UIImage imageNamed:[NSString stringWithFormat:@"badge0%d.png",i+1]]:[UIImage imageNamed:[NSString stringWithFormat:@"badge%d.png",i+1]];
            }
       }
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


    //sendBadgeNameにBadgeDetailVCのreceiveBadgeNAmeに渡したい文字列を入れる
    //sendview.receiveBadgeNameに代入することで値の受け渡しをしている
- (void)badgeTapped:(id)sender {
            sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[[sender tag]][@"terminalId"],flagArray[[sender tag]][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
    
}

- (void)actionizeBadge{
    [self.badge1Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge2Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge3Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge4Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge5Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge6Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge7Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge8Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge9Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge10Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge11Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge12Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge13Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge14Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge15Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.badge16Btn addTarget:self action:@selector(badgeTapped:)
             forControlEvents:UIControlEventTouchUpInside];
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
