//
//  selectSoftwareViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "selectSoftwareViewController.h"
#import "selectVersionViewController.h"

@interface selectSoftwareViewController ()

@end

@implementation selectSoftwareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // セルの数になる
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"softwareCell" forIndexPath:indexPath];
    
    UILabel *softwareName = (UILabel *)[cell viewWithTag:1];
    softwareName.text = @"microsoft";
    return cell;
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *targetCell = (UILabel *)[cell viewWithTag:1];
    self.addData.software = targetCell.text;
    [self performSegueWithIdentifier:@"software" sender:self];
}

//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        selectVersionViewController *nextVC = segue.destinationViewController;
        nextVC.addData = [[additionData alloc]init];
        [nextVC.addData copy:self.addData];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
