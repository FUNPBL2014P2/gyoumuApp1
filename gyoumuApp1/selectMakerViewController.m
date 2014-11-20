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
{
    additionData *addData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    addData = [[additionData alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    selectSoftwareViewController *nextVC = segue.destinationViewController;
    nextVC.addData = [[additionData alloc]init];
    [nextVC.addData copy:addData];
}


- (IBAction)adbBtn:(id)sender {
    addData.maker = @"Adobe";
}

- (IBAction)mcrBtn:(id)sender {
    addData.maker = @"Microsoft";
}

@end