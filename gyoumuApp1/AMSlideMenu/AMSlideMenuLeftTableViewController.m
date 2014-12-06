//
//  AMSlideMenuLeftTableViewController.m
//  AMSlideMenu
//
// The MIT License (MIT)
//
// Created by : arturdev
// Copyright (c) 2014 SocialObjects Software. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

#import "AMSlideMenuLeftTableViewController.h"

#import "AMSlideMenuMainViewController.h"

#import "AMSlideMenuContentSegue.h"
#import "drawRectView.h"
@interface AMSlideMenuLeftTableViewController ()

@end

@implementation AMSlideMenuLeftTableViewController{
    NSString *userName;
    NSString *userLabName;
}

/*----------------------------------------------------*/
#pragma mark - Lifecycle -
/*----------------------------------------------------*/
- (void)viewDidLoad

{
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    NSString *labCode = [NSString stringWithString:[userData valueForKeyPath:@"labCode"]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonUser" ofType:@"txt"];
    NSData *jsondata = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonDlc = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
    
    //キーが「lab」研究室一覧を指定
    NSMutableArray *labAllArray = [jsonDlc objectForKey:@"lab"];
    
    userName = [NSString stringWithString:[userData valueForKeyPath:@"name"]];
    userLabName = [NSString stringWithString:labAllArray[[labCode intValue]-1]];
               
    menuSource = [[NSArray alloc]initWithObjects:
                  @"ライセンス登録",
                  @"ライセンス一覧",
                  @"バッジ",
                  @"研究室一覧",
                  @"設定",
                  @"ログアウト",
                  nil];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [menuSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.textLabel.text = [menuSource objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:30];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([[UIScreen mainScreen]applicationFrame].size.height-sectionHeight)/menuSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    sectionHeight = 100;
    drawRectView* view = [[drawRectView alloc]init];
    view.frame = CGRectMake(0, 100, self.view.frame.size.width, 1);
    [self.view addSubview:view];

    return sectionHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 30.0f)];
    sectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel *menuLabel = [[UILabel alloc] init];
    UILabel *loginuser = [[UILabel alloc] init];
    UILabel *loginuserName = [[UILabel alloc] init];
    UILabel *lab = [[UILabel alloc] init];
    UILabel *labName = [[UILabel alloc] init];
    
    menuLabel.frame = CGRectMake(100, 10, 300, 70);
    menuLabel.textColor = [UIColor blackColor];
    //menuLabel.backgroundColor = [UIColor cyanColor];
    menuLabel.textAlignment = NSTextAlignmentCenter;
    menuLabel.text = @"メニュー";
    menuLabel.font = [UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:25];
    tableView.bounces = NO;
    
    [sectionView addSubview:menuLabel];
    
    lab.frame = CGRectMake(150, 90-15, 90, 20);
    lab.font = [UIFont italicSystemFontOfSize:15];
    lab.textColor = [UIColor blackColor];
    lab.text = [NSString stringWithFormat:@"所属研究室："];
    lab.font = [UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:15];
    [sectionView addSubview:lab];

    
    loginuser.frame = CGRectMake(340, 90-15, 60, 20);
    loginuser.font = [UIFont italicSystemFontOfSize:15];
    loginuser.textColor = [UIColor blackColor];
    loginuser.text = [NSString stringWithFormat:@"ユーザ："];
    loginuser.font = [UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:15];
    [sectionView addSubview:loginuser];
    
    loginuserName.frame = CGRectMake(400, 90-15, 90, 20);
    loginuserName.font = [UIFont italicSystemFontOfSize:15];
    loginuserName.textColor = [UIColor blackColor];
    loginuserName.text = userName;
    loginuserName.font = [UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:15];
    loginuserName.adjustsFontSizeToFitWidth = YES;
    loginuserName.minimumScaleFactor = 0.7f;
    [sectionView addSubview:loginuserName];
    
    labName.frame = CGRectMake(240, 90-15, 150, 20);
    labName.font = [UIFont italicSystemFontOfSize:15];
    labName.textColor = [UIColor blackColor];
    labName.text = userLabName;
    labName.font = [UIFont fontWithName:@"Hiragino Kaku Gothic ProN W3" size:15];
    labName.adjustsFontSizeToFitWidth = YES;
    labName.minimumScaleFactor = 0.5f;
    [sectionView addSubview:labName];
     
    return sectionView;
}

- (void)openContentNavigationController:(UINavigationController *)nvc
{
#ifdef AMSlideMenuWithoutStoryboards
    AMSlideMenuContentSegue *contentSegue = [[AMSlideMenuContentSegue alloc] initWithIdentifier:@"contentSegue" source:self destination:nvc];
    [contentSegue perform];
#else
    NSLog(@"This methos is only for NON storyboard use! You must define AMSlideMenuWithoutStoryboards \n (e.g. #define AMSlideMenuWithoutStoryboards)");
#endif
}


/*----------------------------------------------------*/
#pragma mark - TableView Delegate -
/*----------------------------------------------------*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.mainVC respondsToSelector:@selector(navigationControllerForIndexPathInLeftMenu:)]) {
        UINavigationController *navController = [self.mainVC navigationControllerForIndexPathInLeftMenu:indexPath];
        AMSlideMenuContentSegue *segue = [[AMSlideMenuContentSegue alloc] initWithIdentifier:@"ContentSugue" source:self destination:navController];
        [segue perform];
    } else {
        NSString *segueIdentifier = [self.mainVC segueIdentifierForIndexPathInLeftMenu:indexPath];
        if (segueIdentifier && segueIdentifier.length > 0)
        {
            [self performSegueWithIdentifier:segueIdentifier sender:self];
        }
    }
}


@end
