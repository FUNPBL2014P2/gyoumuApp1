//
//  guestBadgeViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/12/04.
//  Copyright (c) 2014年 shota. All rights reserved.
//


#import "guestBadgeViewController.h"
#import "guestBadgeDetailViewController.h"
#import "AppDelegate.h"
#import "WebdbConnect.h"

@interface guestBadgeViewController ()

@end

@implementation guestBadgeViewController{
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
     NSLog(@"バッジ一覧にて%@を閲覧中",ap.LabPath);
    [self.view sendSubviewToBack:_backgroundView];
    self.badge = [[NSMutableArray alloc] initWithObjects:self.badge1,self.badge2,self.badge3,self.badge4,self.badge5,self.badge6,self.badge7,self.badge8,self.badge9,self.badge10,self.badge11,self.badge12,self.badge13,self.badge14,self.badge15,self.badge16,nil];

    // Do any additional setup after loading the view.
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)badgeTapped:(id)sender {
    sendBadgeName = [NSString stringWithFormat:@"/%@/%@",flagArray[[sender tag]][@"terminalId"],flagArray[[sender tag]][@"datetime"]];
    //バッジ詳細画面のStoryboard IDは"otherBadgeDetail"です
    guestBadgeDetailViewController *sendView = [self.storyboard instantiateViewControllerWithIdentifier:@"guestBadgeDetail"];
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
