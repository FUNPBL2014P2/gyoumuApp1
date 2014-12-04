//
//  guestLabViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/12/04.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "guestLabViewController.h"
#import "AppDelegate.h"
#import "WebdbConnect.h"

@interface guestLabViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation guestLabViewController
{
    NSArray *testName;
    NSMutableArray *labCheckArray;
    NSMutableArray *labAllArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //Supporting Files内のjsonUser.txtを参照
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonUser" ofType:@"txt"];
    NSData *jsondata = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonDlc = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
    
    //キーが「lab」研究室一覧を指定
    labAllArray = [jsonDlc objectForKey:@"lab"];

    // Do any additional setup after loading the view.
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

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       return labAllArray.count;
}
/*
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
*/
/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
}
 */
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //セルの準備
    NSString *cellIdentifier = @"labCell";
    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //labCheckArrayにはログインユーザではない研究室の番号がそれぞれ格納されている。
    //それをtableViewのindexPath.row(上から１列目は０番目なので)によって指定する
    //するとlabCheckArrayは他研究室の番号を示すのでintValueで数値に直す
    //最後にjsonArray1でその数値の対応するjsonUser.txt内の"lab"配列を参照している
    NSString *title =[NSString stringWithFormat:@"%@",labAllArray[indexPath.row]];
    UILabel *label1 = (UILabel *)[cell viewWithTag:1];
    label1.text = title;
    label1.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"%@を選択しています",testName[indexPath.row]);
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //otherLabPathを更新
    ap.LabPath = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [self performSegueWithIdentifier:@"guestTab" sender:self];
    
}

@end
