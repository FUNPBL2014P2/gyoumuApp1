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
#import "AppDelegate.h"

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
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"%@", ap.badgeTitle);
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

@end
