//
//  otherBadgeViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "otherBadgeViewController.h"
#import "otherBadgeDetailViewController.h"
#import "AppDelegate.h"
#import "WebdbConnect.h"
//値渡しのためのimport
#import "WebdbConnect.h"

@interface otherBadgeViewController ()


@end

@implementation otherBadgeViewController{
    NSString *sendBadgeName;
    NSMutableArray *flagArray;
}



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
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    
    WebdbConnect *otherLab = [[WebdbConnect alloc] initWithLabArray:ap.LabPath];
    NSString *otherRecvCount = [[otherLab labEvaluateGet]valueForKeyPath:@"option3"];
    
    NSString *labCode =[userData valueForKeyPath:@"labCode"];
    
    [self evaluateUseCheck:labCode];
    self.evaluateNumber.text = otherRecvCount;
    self.evaluateNumber.textColor = [UIColor blueColor];
    self.badgeEvaluate.layer.cornerRadius = 7;
    //NSString *time = [NSString stringWithFormat:@"%d",abs([self timeCheck:labCode])];
    //NSLog(@"%d",[self timeCheck:labCode]);
    self.evaluateTime.text = [NSString stringWithFormat:@"評価可能まで後%d時間くらいです",abs([self timeCheck:labCode])];
    self.evaluateTime.textColor = [UIColor blueColor];
    
    
    
    //otherLabPathを更新
    NSLog(@"バッジ一覧にて%@を閲覧中",ap.LabPath);
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
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    WebdbConnect *otherLab = [[WebdbConnect alloc] initWithLabArray:ap.LabPath];
    flagArray = [NSMutableArray array];
    NSRange searchResult;
    for(int i = 0; i < otherLab.labArray.count; i++){
        searchResult = [otherLab.labArray[i][@"username"] rangeOfString:@"badge"];
        if (searchResult.location != NSNotFound) {
            [flagArray addObject:otherLab.labArray[i]];
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
            badgeID.image = (i<9)? [UIImage imageNamed:[NSString stringWithFormat:@"badge0%d.gif",i+1]]:[UIImage imageNamed:[NSString stringWithFormat:@"badge%d.gif",i+1]];
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


//sendBadgeNameにotherBadgeDetailVCのreceiveBadgeNAmeに渡したい文字列を入れる
//sendview.receiveBadgeNameに代入することで値の受け渡しをしている
- (IBAction)badge1Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[0][@"terminalId"],flagArray[0][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
    
}

- (IBAction)badge2Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[1][@"terminalId"],flagArray[1][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge3Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[2][@"terminalId"],flagArray[2][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge4Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[3][@"terminalId"],flagArray[3][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge5Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[4][@"terminalId"],flagArray[4][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge6Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[5][@"terminalId"],flagArray[5][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge7Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[6][@"terminalId"],flagArray[6][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge8Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[7][@"terminalId"],flagArray[7][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge9Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[8][@"terminalId"],flagArray[8][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge10Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[9][@"terminalId"],flagArray[9][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge11Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[10][@"terminalId"],flagArray[10][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge12Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[11][@"terminalId"],flagArray[11][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge13Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[12][@"terminalId"],flagArray[12][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge14Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[13][@"terminalId"],flagArray[13][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge15Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[14][@"terminalId"],flagArray[14][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge16Btn:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[15][@"terminalId"],flagArray[15][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
    sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
    [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badgeEvaluateBtn:(id)sender {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    /*
     NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/viewall.php",[userData valueForKeyPath:@"labCode"]];*/
    
    //NSString *test = [userData valueForKeyPath:@"labCode"];
    
    WebdbConnect *myLab = [[WebdbConnect alloc] initWithLabArray:[userData valueForKeyPath:@"labCode"]];
    NSString *myAddCount = [[myLab labEvaluateGet]valueForKeyPath:@"option2"];
    NSString *myRecvCount = [[myLab labEvaluateGet]valueForKeyPath:@"option3"];
    int mAddCount = [myAddCount intValue];
    int mRecvCount = [myRecvCount intValue];
    
    WebdbConnect *otherLab = [[WebdbConnect alloc] initWithLabArray:ap.LabPath];
    NSString *otherAddCount = [[otherLab labEvaluateGet]valueForKeyPath:@"option2"];
    NSString *otherRecvCount = [[otherLab labEvaluateGet]valueForKeyPath:@"option3"];
    int oAddCount = [otherAddCount intValue];
    int oRecvCount = [otherRecvCount intValue];
    
    
    NSLog(@"%@", [userData valueForKeyPath:@"labCode"]);
    
    //NSLog(@"%@", [[myLab labEvaluateGet]valueForKeyPath:@"terminalId"]);
    //NSLog(@"%@", [[myLab labEvaluateGet]valueForKeyPath:@"ap.LabPath"]);
    
    /*NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
     NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
     NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
     NSArray *jsonArray = [jsonDic objectForKey:@"data"];*/
    
    
    
    /////////////////取得日時
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy年MM月dd日 HH時mm分"];
    NSDate *nowGet = [[NSDate alloc]init];
    
    
    
    /////////////////評価した側の処理
    mAddCount += 1;
    
    NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
    
    NSURL *url = [NSURL URLWithString:urlList];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    //パラメータを作成
    NSString *body = [NSString stringWithFormat:@"title=Evaluation&message=&latitude=&longitude=&terminalId=%@&option0=&option1=%@&option2=%d&option3=%d&option4=&option5=",[[myLab labEvaluateGet]valueForKeyPath:@"terminalId"],[fmt stringFromDate:nowGet],mAddCount,mRecvCount];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLConnection *connection;
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //////////////////
    NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],[[myLab labEvaluateGet]valueForKeyPath:@"terminalId"],[[myLab labEvaluateGet]valueForKeyPath:@"datetime"]];
    NSURL *urlDelete = [NSURL URLWithString:strURL];
    NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
    [deleteRequest setHTTPMethod:@"GET"];
    [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
    ///////////////////
    
    
    //////////////////評価された側の処理
    oRecvCount += 1;
    
    
    NSString *urlList1 = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",ap.LabPath];
    //NSLog(@"%@",urlList1);
    NSURL *url1 = [NSURL URLWithString:urlList1];
    
    NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:url1];
    [request1 setHTTPMethod:@"POST"];
    //パラメータを作成
    
    
    NSString *body1 = [NSString stringWithFormat:@"title=Evaluation&message=&latitude=&longitude=&terminalId=%@&option0=&option1=%@&option2=%d&option3=%d",[[otherLab labEvaluateGet]valueForKeyPath:@"terminalId"],[[otherLab labEvaluateGet]valueForKeyPath:@"option1"],oAddCount,oRecvCount];
    request1.HTTPBody = [body1 dataUsingEncoding:NSUTF8StringEncoding];
    NSURLConnection *connection1;
    connection1 = [[NSURLConnection alloc] initWithRequest:request1 delegate:self];
    
    //////////////////
    NSString *strURL1 = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",ap.LabPath,[[otherLab labEvaluateGet]valueForKeyPath:@"terminalId"],[[otherLab labEvaluateGet]valueForKeyPath:@"datetime"]];
    NSURL *urlDelete1 = [NSURL URLWithString:strURL1];
    NSMutableURLRequest *deleteRequest1 = [NSMutableURLRequest requestWithURL:urlDelete1];
    [deleteRequest1 setHTTPMethod:@"GET"];
    [NSURLConnection sendSynchronousRequest:deleteRequest1 returningResponse:nil error:nil];
    
    /*NSString *RecvCount = [NSString stringWithFormat:@"%d"[oRecvCount]];
     
     self.evaluateNumber.text = RecvCount;*/
    self.evaluateNumber.text = [NSString stringWithFormat:@"%d",oRecvCount];
    [_badgeEvaluate setEnabled:NO];
}

-(void) evaluateUseCheck:(NSString *)labCode
{
    /*NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
     NSMutableArray *userData = [userDefaults objectForKey:@"userData"];*/
    
    WebdbConnect *myLab = [[WebdbConnect alloc] initWithLabArray:labCode];
    
    NSString *time_old = [[myLab labEvaluateGet]valueForKeyPath:@"option1"];
    //NSString *otherRecvCount = [[otherLab labEvaluateGet]valueForKeyPath:@"option3"];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy年MM月dd日 HH時mm分"];
    NSDate *nowGet = [[NSDate alloc]init];
    NSString *time_new;
    time_new = [fmt stringFromDate:nowGet];
    
    NSString *subold;
    NSString *subold_day;
    //NSString *subold_hour;
    
    
    NSString *timenew_day;
    //NSString *timenew_hour;
    
    timenew_day = [time_new substringWithRange:NSMakeRange(8, 2)];
    //timenew_hour = [time_new substringWithRange:NSMakeRange(12, 2)];
    
    NSString *sub = [NSString stringWithFormat:@"%@",time_old];
    
    if(sub.length == 0){
        subold= @"0000年00月00日 00時00分";
    }else{
        subold_day = [time_old substringWithRange:NSMakeRange(8, 2)];
        //subold_hour = [time_old substringWithRange:NSMakeRange(12, 2)];
    }
    /*
     int timenew_hour_int =[timenew_hour intValue];
     int subold_hour_int =[subold_hour intValue];*/
    
    
    
    //24時間以内だったら評価不可
    if(sub.length == 0){
        [_badgeEvaluate setEnabled:YES];
    }else if([subold_day isEqualToString:timenew_day]) {
        [_badgeEvaluate setEnabled:NO];
    }else if([self timeCheck:labCode] > 0){
        [_badgeEvaluate setEnabled:YES];
    }
    
}

-(int) timeCheck:(NSString *)labCode{
    
    WebdbConnect *myLab = [[WebdbConnect alloc] initWithLabArray:labCode];
    
    NSString *time_old = [[myLab labEvaluateGet]valueForKeyPath:@"option1"];
    //NSString *otherRecvCount = [[otherLab labEvaluateGet]valueForKeyPath:@"option3"];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy年MM月dd日 HH時mm分"];
    NSDate *nowGet = [[NSDate alloc]init];
    NSString *time_new;
    time_new = [fmt stringFromDate:nowGet];
    
    NSString *subold;
    NSString *subold_day;
    NSString *subold_hour;
    
    
    NSString *timenew_day;
    NSString *timenew_hour;
    
    timenew_day = [time_new substringWithRange:NSMakeRange(8, 2)];
    timenew_hour = [time_new substringWithRange:NSMakeRange(12, 2)];
    NSLog(@"%@",timenew_hour);
    
    NSString *sub = [NSString stringWithFormat:@"%@",time_old];
    
    if(sub.length == 0){
        subold= @"0000年00月00日";
    }else{
        subold_day = [time_old substringWithRange:NSMakeRange(8, 2)];
        subold_hour = [time_old substringWithRange:NSMakeRange(12, 2)];
    }
    
    int timenew_hour_int =[timenew_hour intValue];
    int subold_hour_int =[subold_hour intValue];
    
    if((![subold_day isEqualToString:timenew_day]) && (timenew_hour_int - subold_hour_int >= 0)){
        return 0;
    }
    else if(timenew_hour_int - subold_hour_int >= 0){
        return 24 - (timenew_hour_int - subold_hour_int);
    }else{
        return timenew_hour_int - subold_hour_int;
    }
    
    
}

-(void) time:(NSString *)labCode{
    
    

}



@end
