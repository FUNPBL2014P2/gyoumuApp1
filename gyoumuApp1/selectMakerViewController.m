//
//  selectMakerViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "selectMakerViewController.h"
#import "additionData.h"

@interface selectMakerViewController ()

@end

@implementation selectMakerViewController
{
    additionData *a;
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
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"adb"]){
        
        selectSoftwareViewController *nextVC = segue.destinationViewController;
        nextVC.Receive = [[additionData alloc]init];
        
        nextVC.Receive.maker = @"adasadasa";
    }
}


- (IBAction)adbBtn:(id)sender {
}

- (IBAction)mcrBtn:(id)sender {
}

@end