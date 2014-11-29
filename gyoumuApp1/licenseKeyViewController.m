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

@implementation licenseKeyViewController{
    UITextField *tagField;
    UITextField *keyField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //識別子のtextField
    tagField =
    [[UITextField alloc] initWithFrame:CGRectMake(158, 177, 451, 60)];
    tagField.borderStyle = UITextBorderStyleRoundedRect;
    tagField.keyboardType = UIKeyboardTypeASCIICapable;
    tagField.placeholder = @"識別名を入力してください";
    tagField.autocapitalizationType =  UITextAutocapitalizationTypeNone;
    tagField.clearButtonMode = UITextFieldViewModeAlways;
    
    //ライセンスキーのtextField
    keyField =
    [[UITextField alloc] initWithFrame:CGRectMake(158, 419, 451, 60)];
    keyField.borderStyle = UITextBorderStyleRoundedRect;
    keyField.keyboardType = UIKeyboardTypeASCIICapable;
    keyField.placeholder = @"ライセンスキーを入力してください";
    keyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    keyField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:tagField];
    [self.view addSubview:keyField];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // ここにtextデータの処理
    
    // キーボードを閉じる
    [tagField resignFirstResponder];
    [keyField resignFirstResponder];
    
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

    if(tagField.text.length >= 32){
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"識別名が長過ぎます。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
        
    }else if(tagField.text.length == 0){
    
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"識別名が入力されていません。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
        
    }else if([self havingInvalidPatternIn:tagField.text]){
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"識別名に不正な文字を含んでいます。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
        
        
    }else if(tagField.text.length >= 32){
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"キーが長過ぎます。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
        
    }else if(keyField.text.length == 0){
    
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"ライセンスキーが入力されていません。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
        
    }else if([self havingInvalidPatternIn:keyField.text]){
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"入力エラー" message:@"ライセンスキーに不正な文字を含んでいます。"                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
        
    }
    
    self.addData.tag = tagField.text;
    self.addData.key = keyField.text;
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
