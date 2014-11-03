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
        NSRange badgeKey = [jsonArray[i][@"terminalId"] rangeOfString:@"badge"];//ある文字列を含む
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
    NSLog(@"%@",badgeArray);

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

@end
