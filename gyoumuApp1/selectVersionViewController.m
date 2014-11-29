//
//  selectVersionViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "selectVersionViewController.h"
#import "licenseKeyViewController.h"

@interface selectVersionViewController ()

@end

@implementation selectVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.versionArray = [[NSArray alloc]init];
    self.versionArray = [self detectVersion:self.masterArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // セルの数になる
    return self.versionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"versionCell" forIndexPath:indexPath];
    
    UILabel *versionName = (UILabel *)[cell viewWithTag:1];
    versionName.text = [self.versionArray objectAtIndex:indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *targetCell = (UILabel *)[cell viewWithTag:1];
    self.addData.version = targetCell.text;
    [self performSegueWithIdentifier:@"version" sender:self];
}


//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    licenseKeyViewController *nextVC = segue.destinationViewController;
    nextVC.addData = [[additionData alloc]init];
    [nextVC.addData copy:self.addData];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (NSArray *)detectVersion:(NSMutableArray *)array{
    NSMutableSet *versionSet = [NSMutableSet set];
    for(int i=0;i<array.count;i++){
        if([self.addData.software isEqualToString:[array[i] valueForKeyPath:@"option1"]]){
            [versionSet addObject:[array[i] valueForKeyPath:@"option2"]];
        }
    }
    NSArray *versionArray = [versionSet allObjects];
    return versionArray;
}


@end
