//
//  otherLicenseViewController2.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/21.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "otherLicenseViewController2.h"
#import "AppDelegate.h"
#import "WebdbConnect.h"

@interface otherLicenseViewController2 ()  <UITableViewDelegate, UITableViewDataSource>


@end

@implementation otherLicenseViewController2
{
    WebdbConnect *connect;
    NSMutableArray *licenseArray;
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
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    connect = [[WebdbConnect alloc] init];
    [connect setLabArray:ap.LabPath];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView

{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    containerView.backgroundColor = [UIColor whiteColor];
    UILabel *maker = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 20)];
    maker.text = @"メーカー";
    UILabel *software = [[UILabel alloc] initWithFrame:CGRectMake(maker.frame.origin.x+maker.frame.size.width+40, 10, 200, 20)];
    software.text = @"ソフトウェア";
    UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(software.frame.origin.x+software.frame.size.width+5, 10, 100, 20)];
    version.text = @"バージョン";
    UILabel *own = [[UILabel alloc] initWithFrame:CGRectMake(version.frame.origin.x+version.frame.size.width+50, 10, 50, 20)];
    own.text = @"保管";
    UILabel *rest = [[UILabel alloc] initWithFrame:CGRectMake(own.frame.origin.x+own.frame.size.width+10, 10, 100, 20)];
    rest.text =@"残り日数";
   
    [containerView addSubview:maker];
    [containerView addSubview:software];
    [containerView addSubview:version];
    [containerView addSubview:own];
    [containerView addSubview:rest];

    return containerView;
    /*
    UILabel* header = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 320, 64)];
    header.text = @"メーカー　　　　";
    header.backgroundColor = [UIColor whiteColor];
    return header;
     */
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    NSRange searchResult;
    licenseArray = [NSMutableArray array];
    for (int i =0; i < [connect labArray].count; i++) {
        searchResult = [[connect labArray][i][@"username"] rangeOfString:@"badge"];
        if (searchResult.location != NSNotFound) {
            [licenseArray addObject:[connect labArray][i]];
            count++;
        }
    }
    return count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithHue:0.61 saturation:0.09 brightness:0.99 alpha:1.0];
    } else
    cell.backgroundColor = [UIColor colorWithHue:0.99 saturation:0.09 brightness:0.99 alpha:1.0];
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"myCell2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    UILabel *label1 = (UILabel *)[cell viewWithTag:1];
    label1.text = [NSString stringWithFormat:@"%@",[licenseArray[indexPath.row] valueForKeyPath:@"terminalId"]];
    UILabel *label2 = (UILabel *)[cell viewWithTag:2];
    label2.text = @"Word";
    UILabel *label3 = (UILabel *)[cell viewWithTag:3];
    label3.text = @"2013";
    UILabel *label4 = (UILabel *)[cell viewWithTag:4];
    label4.text = @"3";
    UILabel *label5 = (UILabel *)[cell viewWithTag:5];
    label5.text = @"33";
    
    return cell;
    
    
    
}


/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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
