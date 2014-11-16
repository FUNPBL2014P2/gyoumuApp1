//
//  labViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "labViewController.h"
#import "tabViewController.h"

@interface labViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation labViewController
{
    NSArray *testName;
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
    return 3;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    testName = [NSArray arrayWithObjects:@"奥野研究室",@"大場研究室",@"伊藤研究室", nil];
    //セルの準備
    NSString *cellIdentifier = @"Cell";
    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *title =[NSString stringWithFormat:@"%@",testName[indexPath.row]];
    cell.textLabel.text = title;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@を選択しています",testName[indexPath.row]);
    [self performSegueWithIdentifier:@"tabView" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"tabView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        tabViewController *chengeView = segue.destinationViewController;
        chengeView.labName = testName[indexPath.row];
    }
}
@end
