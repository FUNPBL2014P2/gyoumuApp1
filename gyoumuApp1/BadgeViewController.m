//
//  BadgeViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/10/31.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "BadgeViewController.h"

@interface BadgeViewController ()

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
    NSString *orign = @"http://webdb.per.c.fun.ac.jp/sofline/list.php";
    NSString *url = [NSString stringWithFormat:@"%@",orign];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonDlc = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    //jsonArrayにデータを格納
    NSArray *jsonArray = [jsonDlc objectForKey:@"data"];
    
    NSMutableArray *badgePathArray = [[NSMutableArray alloc]init];
    
    //バッジキー配列の作成
    for(int i = 0; i < jsonArray.count; i++) {
        NSRange badgeKey = [jsonArray[i][@"terminalId"] rangeOfString:@"badge"];
        if (badgeKey.location == NSNotFound) {
        }
        else {
            [badgePathArray addObject:[jsonArray objectAtIndex:i]];
        }
    }
    
    NSMutableArray *badgeArray = [[NSMutableArray alloc]init];
    
    //バッジ内容配列の作成
    for(int i = 0; i < badgePathArray.count; i++) {
        NSString *baseURL = @"http://webdb.per.c.fun.ac.jp/sofline/view.php?data=";
        NSString *pathURL = [baseURL stringByAppendingString:badgePathArray[i][@"path"]];
        NSURLRequest *badgeRequest = [NSURLRequest requestWithURL:[NSURL URLWithString: pathURL]];
        NSData *jsonDataPersonal = [NSURLConnection sendSynchronousRequest:badgeRequest returningResponse:nil error:nil];
        
        [badgeArray addObject:[NSJSONSerialization JSONObjectWithData:jsonDataPersonal options:NSJSONReadingAllowFragments error:nil]];
    }

    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"title" ascending:YES];
    NSArray *sortedBadgeArray = [[NSMutableArray alloc]init];
    NSArray *sortArray = [NSArray arrayWithObjects:sort, nil];
    sortedBadgeArray = [badgeArray sortedArrayUsingDescriptors:sortArray];
    

    /*バッジの表示*/
    for(int i = 0; i < sortedBadgeArray.count; i++) {
        if([sortedBadgeArray[i][@"option0"] isEqualToString:@"1"]){
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

- (IBAction)badge1Btn:(id)sender {
}

- (IBAction)badge2Btn:(id)sender {
}

- (IBAction)badge3Btn:(id)sender {
}

- (IBAction)badge4Btn:(id)sender {
}

- (IBAction)badge5Btn:(id)sender {
}

- (IBAction)badge6Btn:(id)sender {
}

- (IBAction)badge7Btn:(id)sender {
}

- (IBAction)badge8Btn:(id)sender {
}

- (IBAction)badge9Btn:(id)sender {
}

- (IBAction)badge10Btn:(id)sender {
}

- (IBAction)badge11Btn:(id)sender {
}

- (IBAction)badge12Btn:(id)sender {
}

- (IBAction)badge13Btn:(id)sender {
}

- (IBAction)badge14Btn:(id)sender {
}

- (IBAction)badge15Btn:(id)sender {
}

- (IBAction)badge16Btn:(id)sender {
}
@end
