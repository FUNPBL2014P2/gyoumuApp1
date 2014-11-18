//
//  labTableViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/16.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "labTableViewController.h"
#import "AppDelegate.h"
#import "WebdbConnect.h"

@interface labTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation labTableViewController
{
    WebdbConnect *test;
    NSMutableArray *testArray;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    test = [[WebdbConnect alloc] init];
    [test setLabArray:@"1"];
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

-(void) viewWillAppear:(BOOL)animated
{
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //otherLabPathを更新
    NSLog(@"ライセンス一覧にて%@を閲覧中",ap.LabPath);
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView

{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count = 0;
    NSRange searchResult;
    testArray = [NSMutableArray array];
    for (int i =0; i < [test labArray].count; i++) {
        searchResult = [[test labArray][i][@"username"] rangeOfString:@"badge"];
        if (searchResult.location != NSNotFound) {
            [testArray addObject:[test labArray][i]];
            count++;
        }
    }
    return count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    UILabel *label1 = (UILabel *)[cell viewWithTag:1];
    label1.text = [NSString stringWithFormat:@"%@",[testArray[indexPath.row] valueForKeyPath:@"terminalId"]];
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
