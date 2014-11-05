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
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //全体データを取得する処理
    NSString *orign = @"http://webdb.per.c.fun.ac.jp/sofline/viewall.php";
    NSString *url = [NSString stringWithFormat:@"%@",orign];
    
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
/*    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"title" ascending:YES];
    NSArray *sortedBadgeArray = [[NSArray alloc]init];
    NSArray *sortArray = [NSArray arrayWithObjects:sort, nil];
    sortedBadgeArray = (NSMutableArray *)[badgeArray sortedArrayUsingDescriptors:sortArray];
*/
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"title" ascending:YES];
    NSArray *sortArray = [NSArray arrayWithObjects:sort, nil];
    flagArray = (NSMutableArray *)[flagArray sortedArrayUsingDescriptors:sortArray];
 
    
       for(int i = 0; i < flagArray.count; i++) {
        if([flagArray[i][@"option0"] isEqualToString:@"1"]){
            switch (i) {
                case 0:
                    self.badge1.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge1.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 1:
                    self.badge2.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge2.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 2:
                    self.badge3.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge3.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 3:
                    self.badge4.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge4.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 4:
                    self.badge5.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge5.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 5:
                    self.badge6.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge6.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 6:
                    self.badge7.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge7.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 7:
                    self.badge8.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge8.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 8:
                    self.badge9.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge9.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 9:
                    self.badge10.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge10.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 10:
                    self.badge11.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge11.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 11:
                    self.badge12.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge12.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 12:
                    self.badge13.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge13.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 13:
                    self.badge14.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge14.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 14:
                    self.badge15.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge15.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
                case 15:
                    self.badge16.contentMode = UIViewContentModeScaleAspectFill;
                    self.badge16.image = [UIImage imageNamed:@"badge1.gif"];
                    break;
            }
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
- (IBAction)badge1Btn:(id)sender {
            sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[0][@"terminalId"],flagArray[0][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
    
}

- (IBAction)badge2Btn:(id)sender {
           sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[1][@"terminalId"],flagArray[1][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge3Btn:(id)sender {
            sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[2][@"terminalId"],flagArray[2][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge4Btn:(id)sender {
            sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[3][@"terminalId"],flagArray[3][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge5Btn:(id)sender {
        sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[4][@"terminalId"],flagArray[4][@"datetime"]];
       //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge6Btn:(id)sender {
        sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[5][@"terminalId"],flagArray[5][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge7Btn:(id)sender {
        sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[6][@"terminalId"],flagArray[6][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge8Btn:(id)sender {
        sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[7][@"terminalId"],flagArray[7][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge9Btn:(id)sender {
        sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[8][@"terminalId"],flagArray[8][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge10Btn:(id)sender {
        sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[9][@"terminalId"],flagArray[9][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge11Btn:(id)sender {
        sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[10][@"terminalId"],flagArray[10][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge12Btn:(id)sender {
        sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[11][@"terminalId"],flagArray[11][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge13Btn:(id)sender {
        sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[12][@"terminalId"],flagArray[12][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge14Btn:(id)sender {
        sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[13][@"terminalId"],flagArray[13][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge15Btn:(id)sender {
        sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[14][@"terminalId"],flagArray[14][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}

- (IBAction)badge16Btn:(id)sender {
        sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[15][@"terminalId"],flagArray[15][@"datetime"]];
        //バッジ詳細画面のStoryboard IDは"badgeDetail"です
        BadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"badgeDetail"];
        sendView.receiveBadgeName = [NSString stringWithFormat:@"%@",sendBadgeName];
        [self presentViewController:sendView animated:NO completion:nil];
}
@end
