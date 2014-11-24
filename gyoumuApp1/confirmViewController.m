//
//  confirmViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "confirmViewController.h"
#import "finishAddingViewController.h"

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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.addData format];
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    finishAddingViewController *nextVC = segue.destinationViewController;
    nextVC.addData = [[additionData alloc]init];
    [nextVC.addData copy:self.addData];
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

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
- (IBAction)sendBtn:(id)sender {
    [self sendLicenseData];
    [self performSegueWithIdentifier:@"finish" sender:self];
}
@end
