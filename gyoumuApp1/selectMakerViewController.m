//
//  selectMakerViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "selectMakerViewController.h"
#import "selectSoftwareViewController.h"
#import "additionData.h"

@interface selectMakerViewController ()

@end

@implementation selectMakerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.addData = [[additionData alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // セルの数になる
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"makerCell" forIndexPath:indexPath];
    
    UILabel *softwareName = (UILabel *)[cell viewWithTag:1];
    switch (indexPath.row) {
        case 0:
            softwareName.text = @"Adobe";
            break;
            
        case 1:
            softwareName.text = @"Microsoft";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *targetCell = (UILabel *)[cell viewWithTag:1];
    self.addData.maker = targetCell.text;
    NSLog(@"%@",self.addData.maker);
    [self performSegueWithIdentifier:@"maker" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    selectSoftwareViewController *nextVC = segue.destinationViewController;
    nextVC.addData = [[additionData alloc]init];
    [nextVC.addData copy:self.addData];
}

@end