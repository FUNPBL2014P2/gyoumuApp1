//
//  inputDateViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "inputDateViewController.h"
#import "confirmViewController.h"

@interface inputDateViewController ()

@end

@implementation inputDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 confirmViewController *nextVC = segue.destinationViewController;
 nextVC.addData = [[additionData alloc]init];
 [nextVC.addData copy:self.addData];
     
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }

- (IBAction)next:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.addData.start = [dateFormatter stringFromDate:self.startPicker.date];
    self.addData.period = (self.periodState.on)?[dateFormatter stringFromDate:self.periodPiecker.date]:@"";
}
@end
