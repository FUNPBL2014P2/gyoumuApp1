//
//  guestBadgeDetailViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/12/04.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "guestBadgeDetailViewController.h"
#import "AppDelegate.h"

@interface guestBadgeDetailViewController ()

@end

@implementation guestBadgeDetailViewController

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
    [self.view sendSubviewToBack:_detailBackground];
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //NSLog(@"%@",ap.LabPath);
    NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/view.php?data=%@",ap.LabPath,receiveBadgeName];
    NSURL *urlView = [NSURL URLWithString:strURL];
    NSMutableURLRequest *viewRequest = [NSMutableURLRequest requestWithURL:urlView];
    [viewRequest setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];

    [viewRequest setHTTPMethod:@"GET"];
    [NSURLConnection sendSynchronousRequest:viewRequest returningResponse:nil error:nil];
    
    NSData *viewList = [NSURLConnection sendSynchronousRequest:viewRequest returningResponse:nil error:nil];
    NSDictionary *viewDic = [NSJSONSerialization JSONObjectWithData:viewList options:0 error:nil];
    //NSLog(@"%@", viewDic[@"title"]);
    int frag = [viewDic[@"option0"] intValue];
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
    
    


    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
