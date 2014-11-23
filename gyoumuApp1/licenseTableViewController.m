//
//  licenseTableViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/20.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "licenseTableViewController.h"
#import "WebdbConnect.h"
#import "licenseDetailViewController.h"

@interface licenseTableViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation licenseTableViewController
{
    WebdbConnect *connect;
    NSMutableArray *licenseArray;
    NSMutableArray *licenseTableArray;
    NSArray *sortedArray;
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *userdata = [userDefaults objectForKey:@"userData"];
    connect = [[WebdbConnect alloc] initWithLabArray:[userdata valueForKeyPath:@"labCode"]];
    
    NSMutableArray  *licenseArrayTset = [NSMutableArray arrayWithArray:[connect labLicenseGet]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"option7" ascending:YES];
    sortedArray = [licenseArrayTset sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    licenseArray = [[NSMutableArray alloc] init];
    NSString *comp = @"init";
    int count = 0;
    licenseTableArray = [NSMutableArray array];
    comp = @"init";
    for (int i = 0; i < sortedArray.count; i++) {
        
        if (![comp isEqualToString:[sortedArray[i] valueForKeyPath:@"option7"]]) {
            comp = [sortedArray[i]valueForKeyPath:@"option7"];
        for (int j = i; j < sortedArray.count; j++) {
            if ([comp isEqualToString:[sortedArray[j] valueForKeyPath:@"option7"]]) {
                count++;
            }
            
          }
           [licenseTableArray addObject:[NSString stringWithFormat:@"%d",count]];
            [licenseArray addObject:sortedArray[i]];
            count = 0;
           
        }
    }
    
    NSLog(@"%@", licenseTableArray);
    NSLog(@"%@", sortedArray);
    //for (int i = 0; i < [connect labArray].count; i++) {
        
    //}
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

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView

{
    return 1;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        //同名ソフトウェアの数
       return licenseTableArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    } else
        cell.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    licenseDetailViewController *ViewController2 = [self.storyboard instantiateViewControllerWithIdentifier:@"licenseDetail"];
    ViewController2.softReceiveData =[licenseArray[indexPath.row] valueForKeyPath:@"option7"];
    [self presentViewController:ViewController2 animated:NO completion:nil];
    
    NSLog(@"押されたんご");
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"myCell2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    UILabel *label1 = (UILabel *)[cell viewWithTag:1];
    label1.text = [NSString stringWithFormat:@"%@",[licenseArray[indexPath.row] valueForKeyPath:@"option0"]];
    UILabel *label2 = (UILabel *)[cell viewWithTag:2];
    label2.text = [NSString stringWithFormat:@"%@",[licenseArray[indexPath.row] valueForKeyPath:@"option1"]];    UILabel *label3 = (UILabel *)[cell viewWithTag:3];
    label3.text = [NSString stringWithFormat:@"%@",[licenseArray[indexPath.row] valueForKeyPath:@"option2"]];
    UILabel *label4 = (UILabel *)[cell viewWithTag:4];
    label4.text = [NSString stringWithFormat:@"%@", licenseTableArray[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}

-(IBAction)returnMain3:(UIStoryboardSegue *)sender
{
    
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
