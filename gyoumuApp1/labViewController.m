//
//  labViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "labViewController.h"
#import "tabViewController.h"
#import "AppDelegate.h"
#import "WebdbConnect.h"

@interface labViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation labViewController
{
    NSArray *testName;
    NSMutableArray *labCheckArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    labCheckArray = [NSMutableArray array];
    int labNumber = 3;
    NSInteger labCount = 0;
    for (int i = 0; i < labNumber; i++) {
        if (i+1 != [[userData valueForKeyPath:@"labCode"] intValue]) {
            [labCheckArray addObject:[NSNumber numberWithInteger:i+1]];
            labCount++;
        }
    }
    NSLog(@"%@",labCheckArray);
    return labCount;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Supporting Files内のjsonUser.txtを参照
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonUser" ofType:@"txt"];
    NSData *jsondata = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonDlc = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
    
    //キーが「lab」研究室一覧を指定
    NSMutableArray *jsonArray1 = [jsonDlc objectForKey:@"lab"];
    //NSLog(@"%@",jsonArray1);
    //

    //セルの準備
    NSString *cellIdentifier = @"Cell";
    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //labCheckArrayにはログインユーザではない研究室の番号がそれぞれ格納されている。
    //それをtableViewのindexPath.row(上から１列目は０番目なので)によって指定する
    //するとlabCheckArrayは他研究室の番号を示すのでintValueで数値に直す
    //最後にjsonArray1でその数値の対応するjsonUser.txt内の"lab"配列を参照している
    NSString *title =[NSString stringWithFormat:@"%@",jsonArray1[[labCheckArray[indexPath.row] intValue]-1]];
    cell.textLabel.text = title;
   
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"%@を選択しています",testName[indexPath.row]);
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //otherLabPathを更新
    ap.LabPath = labCheckArray[indexPath.row];
    [self performSegueWithIdentifier:@"tabView" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Supporting Files内のjsonUser.txtを参照
    NSString *path = [[NSBundle mainBundle] pathForResource:@"jsonUser" ofType:@"txt"];
    NSData *jsondata = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonDlc = [NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
    
    //キーが「lab」研究室一覧を指定
    NSMutableArray *jsonArray1 = [jsonDlc objectForKey:@"lab"];
    //NSLog(@"%@",jsonArray1);
    //

    if ([[segue identifier] isEqualToString:@"tabView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        tabViewController *chengeView = segue.destinationViewController;
        chengeView.labName = jsonArray1[[labCheckArray[indexPath.row] intValue]-1];
    }
}
@end
