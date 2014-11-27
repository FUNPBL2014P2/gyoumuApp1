//
//  confirmViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "confirmViewController.h"
#import "additionData.h"
#import "WebdbConnect.h"
#import "selectMakerViewController.h"
#import "selectSoftwareViewController.h"
#import "selectVersionViewController.h"
#import "licenseKeyViewController.h"
#import "inputDateViewController.h"


@interface confirmViewController ()

@end

@implementation confirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
 
    [super viewWillAppear:YES];
    
    self.makerLabel.text = self.addData.maker;
    self.softwareLabel.text = self.addData.software;
    self.versionLabel.text = self.addData.version;
    self.tagLabel.text = self.addData.tag;
    self.keyLabel.text = self.addData.key;
    self.startLabel.text = self.addData.start;
    self.periodLabel.text = self.addData.period;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 inputDateViewController *nextVC = segue.destinationViewController;
 nextVC.addData = [[additionData alloc]init];
 [nextVC.addData copy:self.addData];
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)sendLicenseData{
    NSString *option7 = [self.addData.maker stringByAppendingString:[self.addData.software stringByAppendingString:self.addData.version]];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
    
    NSURL *url = [NSURL URLWithString:urlList];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    //パラメータを作成
    NSString *body = [NSString stringWithFormat:@"title=ライセンス&message=&latitude=&longitude=&terminalId=ライセンス&option0=%@&option1=%@&option2=%@&option3=%@&option4=%@&option5=%@&option6=%@&option7=%@",self.addData.maker, self.addData.software, self.addData.version, self.addData.tag, self.addData.key, self.addData.start, self.addData.period,option7];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLConnection *connection;
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                      /*
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLConnection *connection;
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];}
                       */
                      }

- (BOOL)checkInputData{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    
    if(self.addData.maker.length == 0){
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"メーカーの値が不正です。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return NO;
        
    }else if(self.addData.software.length == 0){
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"ソフトウェアの値が不正です。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return NO;
        
    }else if(self.addData.version.length == 0){
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"バージョンの値が不正です。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return NO;
        
    }else if(self.addData.tag.length == 0){
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"識別名の値が不正です。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return NO;
        
    }else if(self.addData.key.length == 0){
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"ライセンスキーの値が不正です。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return NO;
        
    }else if(self.addData.start.length == 0){
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"購入日時の値が不正です。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return NO;
    }else if([self.addData isDuplicatedTag: [userData valueForKeyPath:@"labCode"]:self.addData.tag]){
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"識別名が重複しています。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    return NO;
    }
    return YES;
}

- (IBAction)sendBtn:(id)sender {
    if(![self checkInputData])return;
    [self sendLicenseData];
    [self.addData format];
    [self performSegueWithIdentifier:@"finish" sender:self];
}
- (IBAction)makerEdit:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

- (IBAction)softwareEdit:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
}

- (IBAction)versionEdit:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3] animated:YES];}

- (IBAction)tagEdit:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:4] animated:YES];}

- (IBAction)keyEdit:(id)sender {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:4] animated:YES];
}

- (IBAction)startEdit:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:5] animated:YES];}

- (IBAction)periodEdit:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:5] animated:YES];}


-(void) addLicenseBtn:(int) flagCount :(NSString *) badgeTitle
{
    //Viewall用
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    WebdbConnect *myLab = [[WebdbConnect alloc] initWithLabArray:[userData valueForKeyPath:@"labCode"]];
    NSObject *jsonArray =[myLab labBadgeGet:badgeTitle];
    
    if ( [[jsonArray valueForKeyPath:@"option0"] isEqualToString:@"1"]) {
        return;
    }
    
    int count = [[jsonArray valueForKeyPath:@"option2"] intValue] + 1;
    
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
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"バッジ取得" message:[jsonArray valueForKeyPath:@"option3"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

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
        
        //削除したら抜ける
        return ;
    }

}
@end
