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
@property (nonatomic) int time;
@property (nonatomic, strong) NSTimer *countdown_timer;


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
    [self actionizeBadge];
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    
    WebdbConnect *otherLab = [[WebdbConnect alloc] initWithLabArray:ap.LabPath];
    NSString *otherRecvCount = [[otherLab labEvaluateGet]valueForKeyPath:@"option3"];
    NSString *labCode =[userData valueForKeyPath:@"labCode"];
    
    _countdown_timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                        target:self
                                                      selector:@selector(update)
                                                      userInfo:nil
                                                       repeats:YES];
    _time = [self timeReverse:labCode];
    [_countdown_timer fire];
    
    [self evaluateUseCheck:labCode];
    self.evaluateNumber.text = otherRecvCount;
    self.communeNumberImage.image = [UIImage imageNamed: [NSString stringWithFormat:@"checkLog.png"]];
    [self.view sendSubviewToBack:self.communeNumberImage];
    self.evaluateNumber.textColor = [UIColor blueColor];
    self.evaluateNumber.textAlignment = NSTextAlignmentCenter;
    self.evaluateBtn.layer.cornerRadius = 7;
    //NSString *time = [NSString stringWithFormat:@"%d",abs([self timeCheck:labCode])];
    //NSLog(@"%d",[self timeCheck:labCode]);
    int time_hour = _time/3600;
    int time_minute = (_time - time_hour*3600)/60;
    self.evaluateTime.text = [NSString stringWithFormat:@"評価可能まであと%02d時間%02d分です",time_hour,time_minute];
    self.evaluateTime.textColor = [UIColor whiteColor];
    
    //otherLabPathを更新
    NSLog(@"バッジ一覧にて%@を閲覧中",ap.LabPath);
    NSLog(@"c%d",[self timeReverse:labCode]);
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
     self.badge1.image = [UIImage imageNamed:@"badge01.png"];
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
            badgeID.image = (i<9)? [UIImage imageNamed:[NSString stringWithFormat:@"badge0%d.png",i+1]]:[UIImage imageNamed:[NSString stringWithFormat:@"badge%d.png",i+1]];
        }
    }
}

- (void) update{
    if (_time <= 0.0) {
        [_countdown_timer invalidate];
        [_evaluateBtn setEnabled:YES];
         self.communeImage.image = [UIImage imageNamed: [NSString stringWithFormat:@"checkBtn.png"]];
    }
    else {
        _time--;
        int time_hour = _time/3600;
        int time_minute = (_time - time_hour*3600)/60;
        self.evaluateTime.text = [NSString stringWithFormat:@"評価可能まであと%02d時間%02d分です",time_hour,time_minute];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSLog(@"ap = %@",ap.badgeTitle);
    
        if(ap.badgeTitle){
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"バッジ取得" message:ap.badgeTitle delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            ap.badgeTitle = nil;
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


//sendBadgeNameにotherBadgeDetailVCのreceiveBadgeNAmeに渡したい文字列を入れる
//sendview.receiveBadgeNameに代入することで値の受け渡しをしている
- (void)badgeTapped:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[[sender tag]][@"terminalId"],flagArray[[sender tag]][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    otherBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"otherBadgeDetail"];
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

- (IBAction)evaluateBtn:(id)sender {
    
    self.communeImage.image = [UIImage imageNamed: [NSString stringWithFormat:@"checkBtn2.png"]];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    
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
    _time = 24*60*60;
    int time_hour = _time/3600;
    int time_minute = (_time - time_hour*3600)/60;
    self.evaluateTime.text = [NSString stringWithFormat:@"評価可能まであと%02d時間%02d分です",time_hour,time_minute];
    [_evaluateBtn setEnabled:NO];
    
    [self evaluateAddCheck:1 :@"04"];
    [self evaluateAddCheck:5 :@"08"];
    
}

-(void) evaluateUseCheck:(NSString *)labCode
{
    
    WebdbConnect *myLab = [[WebdbConnect alloc] initWithLabArray:labCode];
    
    NSString *time_old = [[myLab labEvaluateGet]valueForKeyPath:@"option1"];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy年MM月dd日 HH時mm分"];
    NSDate *nowGet = [[NSDate alloc]init];
    NSString *time_new;
    time_new = [fmt stringFromDate:nowGet];
    
    NSString *subold;
    NSString *subold_day;
    NSString *timenew_day;

    timenew_day = [time_new substringWithRange:NSMakeRange(8, 2)];
    
    NSString *sub = [NSString stringWithFormat:@"%@",time_old];
    
    if(sub.length == 0){
        subold= @"0000年00月00日 00時00分";
    }else{
        subold_day = [time_old substringWithRange:NSMakeRange(8, 2)];
    }
    
    
    //24時間以内だったら評価不可
    if(sub.length == 0){
        [_evaluateBtn setEnabled:YES];
         self.communeImage.image = [UIImage imageNamed: [NSString stringWithFormat:@"checkBtn.png"]];
    }else if(_time == 0){
        [_evaluateBtn setEnabled:YES];
         self.communeImage.image = [UIImage imageNamed: [NSString stringWithFormat:@"checkBtn.png"]];
    }else if(_time > 0){
        [_evaluateBtn setEnabled:NO];
        self.communeImage.image = [UIImage imageNamed: [NSString stringWithFormat:@"checkBtn2.png"]];
    }
    
}

-(int) timeReverse:(NSString *)labCode{
    
    WebdbConnect *myLab = [[WebdbConnect alloc] initWithLabArray:labCode];
    NSString *time_old = [[myLab labEvaluateGet]valueForKeyPath:@"option1"];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy年MM月dd日 HH時mm分"];
    NSDate *nowGet = [[NSDate alloc]init];
    NSString *time_new;
    time_new = [fmt stringFromDate:nowGet];
    
    NSDate *resDate = [nowGet initWithTimeInterval:-1*24*60*60 sinceDate:nowGet];
    NSString *lastday= [fmt stringFromDate:resDate];
    
    NSString *last = [lastday substringWithRange:NSMakeRange(8, 2)];
    
    NSString *subold;
    NSString *subold_day;
    NSString *subold_hour;
    NSString *subold_minute;
    
    NSString *timenew_day;
    NSString *timenew_hour;
    NSString *timenew_minute;
    
    timenew_day = [time_new substringWithRange:NSMakeRange(8, 2)];
    timenew_hour = [time_new substringWithRange:NSMakeRange(12, 2)];
    timenew_minute = [time_new substringWithRange:NSMakeRange(15, 2)];
    
    NSString *sub = [NSString stringWithFormat:@"%@",time_old];
    
    if(sub.length == 0){
        subold= @"0000年00月00日";
    }else{
        subold_day = [time_old substringWithRange:NSMakeRange(8, 2)];
        subold_hour = [time_old substringWithRange:NSMakeRange(12, 2)];
        subold_minute = [time_old substringWithRange:NSMakeRange(15, 2)];
    }
    
    int timenew_hour_int =[timenew_hour intValue];
    int subold_hour_int =[subold_hour intValue];
    int timenew_minute_int =[timenew_minute intValue];
    int subold_minute_int =[subold_minute intValue];

    int reverse_minute = timenew_minute_int - subold_minute_int;
    int reverse_hour;
    
    if(reverse_minute < 0){
        reverse_hour = (timenew_hour_int - subold_hour_int) - 1;
        reverse_minute = 60 + reverse_minute;
    }else{
        reverse_hour = timenew_hour_int - subold_hour_int;
    }
    
    NSLog(@"a%d",reverse_hour);
    NSLog(@"b%d",reverse_minute);
    
    int total_second1 = ((subold_hour_int - timenew_hour_int) * 60 * 60) + ((subold_minute_int - timenew_minute_int) * 60);
    int total_second2 = 24*60*60 - (abs(reverse_hour * 60 * 60) + (reverse_minute * 60));
    
    if((![subold_day isEqualToString:timenew_day]) && (reverse_hour >= 0)){
        return 0;
    }else if(![last isEqualToString:subold_day] && ![subold_day isEqualToString:timenew_day]){
        return 0;
    }else if([last isEqualToString:subold_day] && reverse_hour <= 0){
        return total_second1;
    }else if([subold_day isEqualToString:timenew_day] && reverse_hour >=0){
        return total_second2;
    }
    
    return 10;

}

-(void) evaluateAddCheck:(int) flagCount :(NSString *) badgeTitle
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    WebdbConnect *badge = [[WebdbConnect alloc] init];
    WebdbConnect *myLab = [[WebdbConnect alloc] initWithLabArray:[userData valueForKeyPath:@"labCode"]];
    NSObject *jsonArray = [myLab labBadgeGet:badgeTitle];
    
    if ( [[jsonArray valueForKeyPath:@"option0"] isEqualToString:@"1"]) {
        return;
    }
    int count = [[[myLab labEvaluateGet]valueForKeyPath:@"option2"] intValue];
    
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
        
        UIAlertView *alert =
        
        [[UIAlertView alloc] initWithTitle:@"バッジ取得" message:[jsonArray valueForKeyPath:@"option3"]
         
                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        [badge badgeOwnGet];
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
        return ;
        /////////////////////
        
        
        
    }
}


@end
