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
    [self.periodState addTarget:self action:@selector(changedSwitchValue:)
 forControlEvents:UIControlEventValueChanged];
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
    
    if(self.periodState.on == YES && self.periodPiecker.date == [self.startPicker.date earlierDate:self.periodPiecker.date]){
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"購入日時または有効期限の値が不正です。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.addData.start = [dateFormatter stringFromDate:self.startPicker.date];
        self.addData.period = (self.periodState.on)?[dateFormatter stringFromDate:self.periodPiecker.date]:@"";
        [self performSegueWithIdentifier:@"date" sender:self];
}


-(void)changedSwitchValue:(UISwitch*)state{
    self.periodPiecker.backgroundColor = (state.on) ? [[[[UIApplication sharedApplication] delegate] window] tintColor]:[UIColor lightGrayColor];
    [self.periodPiecker setUserInteractionEnabled:(state.on) ?YES:NO];
    self.periodPiecker.maximumDate = (state.on) ? [NSDate dateWithTimeIntervalSinceNow:4]:[NSDate dateWithTimeIntervalSinceNow:0];
    self.periodPiecker.maximumDate = (state.on) ? [NSDate dateWithTimeIntervalSinceNow:4]:[NSDate dateWithTimeIntervalSinceNow:0];
}


@end
