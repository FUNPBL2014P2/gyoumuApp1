//
//  licenseKeyViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "licenseKeyViewController.h"
#import "inputDateViewController.h"

@interface licenseKeyViewController ()

@end

@implementation licenseKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    inputDateViewController *nextVC = segue.destinationViewController;
    nextVC.addData = [[additionData alloc]init];
    [nextVC.addData copy:self.addData];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



- (IBAction)next:(id)sender {

    if(self.tagField.text.length >= 32){
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"識別子が長過ぎます。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
        
    }else if(self.tagField.text.length == 0){
    
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"識別子が入力されていません。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
        
    }else if([self havingInvalidPatternIn:self.tagField.text]){
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"識別子に不正な文字を含んでいます。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
        
        
    }else if(self.tagField.text.length >= 32){
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"キーが長過ぎます。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
        
    }else if(self.keyField.text.length == 0){
    
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"ライセンスキーが入力されていません。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
        
    }else if([self havingInvalidPatternIn:self.keyField.text]){
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"ライセンスキーに不正な文字を含んでいます。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
        
    }
    
    self.addData.tag = self.tagField.text;
    self.addData.key = self.keyField.text;
    [self performSegueWithIdentifier:@"key" sender:self];
    
}

- (BOOL)havingInvalidPatternIn:(NSString *)txt{
    NSRange spaceResult = [txt rangeOfString:@" "];
    
    if(spaceResult.location != NSNotFound){
        return YES;
    }else if(![txt canBeConvertedToEncoding:NSASCIIStringEncoding]){
        return YES;
    }
    return NO;
}

@end
