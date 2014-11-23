//
//  otherLicenseDetailViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/23.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "otherLicenseDetailViewController.h"
#import "WebdbConnect.h"
#import "AppDelegate.h"

@interface otherLicenseDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *makerLabel;
@property (weak, nonatomic) IBOutlet UILabel *softwareLabel;
@property (weak, nonatomic) IBOutlet UILabel *verLabel;

@end

@implementation otherLicenseDetailViewController
{
    NSArray *softArray;
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
    WebdbConnect *connect = [[WebdbConnect alloc] initWithLabArray:ap.LabPath];
    //[connect labLicenseCodeGet:softReceiveData];
    NSLog(@"%@",[connect labLicenseCodeGet:ap.softwareCode]);
    softArray = [[NSArray alloc] init];
    softArray = [connect labLicenseCodeGet:ap.softwareCode];
    self.makerLabel.text = [softArray[0] valueForKeyPath:@"option0"];
    self.softwareLabel.text = [softArray[0] valueForKeyPath:@"option1"];
    self.verLabel.text = [softArray[0] valueForKeyPath:@"option2"];
    // Do any additional setup after loading the view.
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
    return softArray.count;
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


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"softwareCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    UILabel *label1 = (UILabel *)[cell viewWithTag:1];
    label1.text = [NSString stringWithFormat:@"%@",[softArray[indexPath.row] valueForKeyPath:@"option3"]];
    UILabel *label2 = (UILabel *)[cell viewWithTag:2];
    label2.text = [NSString stringWithFormat:@"%@",[softArray[indexPath.row] valueForKeyPath:@"option5"]];
    UILabel *label3 = (UILabel *)[cell viewWithTag:3];
    label3.text = [NSString stringWithFormat:@"%@",[softArray[indexPath.row] valueForKeyPath:@"option6"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
    
}


@end
