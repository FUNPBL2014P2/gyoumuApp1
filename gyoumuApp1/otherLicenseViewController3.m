//
//  otherLicenseViewController3.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/22.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "otherLicenseViewController3.h"
#import "AppDelegate.h"
#import "WebdbConnect.h"
#import "otherLicenseDetailViewController.h"
#import "licenseCollect.h"

@interface otherLicenseViewController3 () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) int time;
@property (nonatomic, strong) NSTimer *countdown_timer;

@end

@implementation otherLicenseViewController3

{
    
    licenseCollect *lc;
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
    WebdbConnect *connect = [[WebdbConnect alloc] init];
    [connect setLabArray:ap.LabPath];
    lc = [[licenseCollect alloc] init];
    [lc setLicenseArray:connect];
    
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
    self.receiveNumber.text = otherRecvCount;
    self.receiveImage.image = [UIImage imageNamed: [NSString stringWithFormat:@"checkLog.png"]];
    [self.view sendSubviewToBack:self.receiveImage];
    self.receiveNumber.textColor = [UIColor blueColor];
    self.receiveNumber.textAlignment = NSTextAlignmentCenter;
    self.communeImage.layer.cornerRadius = 7;
    //NSString *time = [NSString stringWithFormat:@"%d",abs([self timeCheck:labCode])];
    //NSLog(@"%d",[self timeCheck:labCode]);
    int time_hour = _time/3600;
    int time_minute = (_time - time_hour*3600)/60;
    if (_time <= 0.0) {
        [self.communeTime setHidden:YES];
    }
    self.communeTime.text = [NSString stringWithFormat:@"評価可能まであと%02d時間%02d分です",time_hour,time_minute];
    self.communeTime.textColor = [UIColor blueColor];
    
    //for (int i = 0; i < [connect labArray].count; i++) {
    
    //}
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)viewWillAppear:(BOOL)animated{
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
    self.receiveNumber.text = otherRecvCount;
    self.receiveImage.image = [UIImage imageNamed: [NSString stringWithFormat:@"checkLog.png"]];
    [self.view sendSubviewToBack:self.receiveImage];
    self.receiveNumber.textColor = [UIColor blueColor];
    self.receiveNumber.textAlignment = NSTextAlignmentCenter;
    self.communeImage.layer.cornerRadius = 7;
    //NSString *time = [NSString stringWithFormat:@"%d",abs([self timeCheck:labCode])];
    //NSLog(@"%d",[self timeCheck:labCode]);
    int time_hour = _time/3600;
    int time_minute = (_time - time_hour*3600)/60;
    if (_time <= 0.0) {
        [self.communeTime setHidden:YES];
    }
    self.communeTime.text = [NSString stringWithFormat:@"評価可能まであと%02d時間%02d分です",time_hour,time_minute];
    self.communeTime.textColor = [UIColor blueColor];
    
}
- (void) update{
    if (_time <= 0.0) {
        [_countdown_timer invalidate];
        [_communeBtn setEnabled:YES];
        self.communeImage.image = [UIImage imageNamed: [NSString stringWithFormat:@"checkBtn.png"]];
        [self.communeTime setHidden:YES];
    }
    else {
        _time--;
        int time_hour = _time/3600;
        int time_minute = (_time - time_hour*3600)/60;
        [self.communeTime setHidden:NO];
        self.communeTime.text = [NSString stringWithFormat:@"評価可能まであと%02d時間%02d分です",time_hour,time_minute];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView

{
    return 1;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //同名ソフトウェアの数
    return lc.countRow;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    } else
        cell.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ap.softwareCode =[lc softwareCode:(int)indexPath.row];
    [self performSegueWithIdentifier:@"otherLicenseDetail" sender:self];
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"myCell2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    UILabel *label1 = (UILabel *)[cell viewWithTag:1];
    label1.text = [NSString stringWithFormat:@"%@",[lc maker:(int)indexPath.row]];
    UILabel *label2 = (UILabel *)[cell viewWithTag:2];
    label2.text = [NSString stringWithFormat:@"%@ %@",[lc software:(int)indexPath.row],[lc version:(int)indexPath.row]];
    UILabel *label4 = (UILabel *)[cell viewWithTag:4];
    label4.text = [NSString stringWithFormat:@"%@",[lc ownCount:(int)indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}

-(IBAction)returnMain5:(UIStoryboardSegue *)sender
{
    
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
        [_communeBtn setEnabled:YES];
        self.communeImage.image = [UIImage imageNamed: [NSString stringWithFormat:@"checkBtn.png"]];
    }else if(_time == 0){
        [_communeBtn setEnabled:YES];
        self.communeImage.image = [UIImage imageNamed: [NSString stringWithFormat:@"checkBtn.png"]];
    }else if(_time > 0){
        [_communeBtn setEnabled:NO];
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

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)communeBtn:(id)sender {
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
    self.receiveNumber.text = [NSString stringWithFormat:@"%d",oRecvCount];
    _time = 24*60*60;
    int time_hour = _time/3600;
    int time_minute = (_time - time_hour*3600)/60;
    self.communeTime.text = [NSString stringWithFormat:@"評価可能まであと%02d時間%02d分です",time_hour,time_minute];
    [self.communeBtn setEnabled:NO];
    [self.communeTime setHidden:NO];
    [self evaluateAddCheck:1 :@"04"];
    [self evaluateAddCheck:5 :@"08"];
}
@end
