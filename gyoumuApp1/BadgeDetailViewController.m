//
//  BadgeDetailViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/03.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "BadgeDetailViewController.h"
#import "WebdbConnect.h"
#import "AppDelegate.h"

@interface BadgeDetailViewController ()

@end


@implementation BadgeDetailViewController

@synthesize receiveBadgeName;
@synthesize badgeExpLabel;
@synthesize badgeConditionLabel;
@synthesize badgeGetTimeLabel;
@synthesize badgeNumLabel;
@synthesize badgeTitleLabel;

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
        [self.view sendSubviewToBack:_detailBackground];
    
    //NSLog(@"%@", receiveBadgeName);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];

    NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/view.php?data=%@",[userData valueForKeyPath:@"labCode"],receiveBadgeName];
    NSURL *urlView = [NSURL URLWithString:strURL];
    NSMutableURLRequest *viewRequest = [NSMutableURLRequest requestWithURL:urlView];
    [viewRequest setHTTPMethod:@"GET"];
    [NSURLConnection sendSynchronousRequest:viewRequest returningResponse:nil error:nil];
    ///////////////////
    
    NSData *viewList = [NSURLConnection sendSynchronousRequest:viewRequest returningResponse:nil error:nil];
    NSDictionary *viewDic = [NSJSONSerialization JSONObjectWithData:viewList options:0 error:nil];
        //NSLog(@"%@", viewDic[@"title"]);
    int frag = [viewDic[@"option0"] intValue];
    //[self detailCheck:3 :@"02"];
    if(frag == 1){
        
    NSString *num = [NSString stringWithFormat:@"%@",viewDic[@"title"]];
    badgeNumLabel.text = [NSString stringWithFormat:@"No.%@",viewDic[@"title"]];
    badgeTitleLabel.text = [NSString stringWithFormat:@"%@",viewDic[@"option3"]];
        
        NSString *body = [NSString stringWithFormat:@"badge"];
        
        NSString *aString = [body stringByAppendingString:[NSString stringWithFormat:@"%@.png",num]];
        //NSLog(@"%@",aString);
        self.badgeImage.contentMode = UIViewContentModeScaleAspectFill;
        self.badgeImage.image = [UIImage imageNamed:aString];
        
        
    badgeExpLabel.text = [NSString stringWithFormat:@"%@",viewDic[@"option4"]];
    badgeConditionLabel.text = [NSString stringWithFormat:@"%@",viewDic[@"option5"]];
    badgeGetTimeLabel.text = [NSString stringWithFormat:@"%@",viewDic[@"option1"]];
        
    }else if(frag == 0){
        badgeNumLabel.text = [NSString stringWithFormat:@"No.%@",viewDic[@"title"]];
        badgeTitleLabel.text = [NSString stringWithFormat:@"%@",viewDic[@"option3"]];
        badgeExpLabel.text = [NSString stringWithFormat:@"%@",viewDic[@"option4"]];
        badgeConditionLabel.text = [NSString stringWithFormat:@"?????????????"];
        badgeGetTimeLabel.text = @"";
        
    }
    
    [self detailCheck:1 :@"02"];
}

- (void) viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];

    WebdbConnect *myLab = [[WebdbConnect alloc] initWithLabArray:[userData valueForKeyPath:@"labCode"]];
    NSString *title = [receiveBadgeName substringWithRange:NSMakeRange(6, 2)];
    NSLog(@"%@",title);
    NSObject *jsonArray =[myLab labBadgeGet:title];
    
    if([[jsonArray valueForKeyPath:@"option0"] isEqualToString:@"1"]){
        
        badgeNumLabel.text = [NSString stringWithFormat:@"No.%@",[jsonArray valueForKeyPath:@"title"]];
        badgeTitleLabel.text = [NSString stringWithFormat:@"%@",[jsonArray valueForKeyPath:@"option3"]];
        
        NSString *body = [NSString stringWithFormat:@"badge"];
        
        NSString *aString = [body stringByAppendingString:[NSString stringWithFormat:@"%@.png",[jsonArray valueForKeyPath:@"title"]]];
        
        self.badgeImage.contentMode = UIViewContentModeScaleAspectFill;
        self.badgeImage.image = [UIImage imageNamed:aString];
        
        badgeExpLabel.text = [NSString stringWithFormat:@"%@",[jsonArray valueForKeyPath:@"option4"]];
        badgeConditionLabel.text = [NSString stringWithFormat:@"%@",[jsonArray valueForKeyPath:@"option5"]];
        badgeGetTimeLabel.text = [NSString stringWithFormat:@"%@",[jsonArray valueForKeyPath:@"option1"]];
        
    }else{
        
        badgeNumLabel.text = [NSString stringWithFormat:@"No.%@",[jsonArray valueForKeyPath:@"title"]];
        badgeTitleLabel.text = [NSString stringWithFormat:@"%@",[jsonArray valueForKeyPath:@"option3"]];
        badgeExpLabel.text = [NSString stringWithFormat:@"%@",[jsonArray valueForKeyPath:@"option4"]];
        badgeConditionLabel.text = [NSString stringWithFormat:@"%@",[jsonArray valueForKeyPath:@"option5"]];
        badgeConditionLabel.text = [NSString stringWithFormat:@"?????????????"];
        badgeGetTimeLabel.text = @"";
        
    }
 
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) detailCheck:(int) flagCount :(NSString *) badgeTitle
{
    //Viewall用
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    WebdbConnect *badge = [[WebdbConnect alloc] init];
    WebdbConnect *myLab = [[WebdbConnect alloc] initWithLabArray:[userData valueForKeyPath:@"labCode"]];
    NSObject *jsonArray =[myLab labBadgeGet:badgeTitle];
    
    if ( [[jsonArray valueForKeyPath:@"option0"] isEqualToString:@"1"]) {
        return;
    }
    
    int count = [[jsonArray valueForKeyPath:@"option2"] intValue] + 1;
    NSLog(@"%d",count);
    
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
        
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"バッジ取得" message:[jsonArray valueForKeyPath:@"option3"]delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        [badge badgeOwnGet];
        return ;
    
    }else if (count < flagCount) {
        
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
