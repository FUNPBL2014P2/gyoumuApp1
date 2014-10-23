//
//  MenuViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/10/17.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "MenuViewController.h"
#import "ViewController.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString*) segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath{
    NSString *identifier;
    
    switch (indexPath.row) {
            //ライセンス登録
        case 0:
            identifier=@"firstSegue";
            break;
            //ライセンス一覧
        case 1:
            identifier=@"secondSegue";
            break;
            //バッジ機能
        case 2:
            identifier=@"thirdSegue";
            break;
            //研究室一覧
        case 3:
            identifier=@"fourthSegue";
            break;
            //設定
        case 4:
            identifier=@"fifthSegue";
            break;
            //ログアウト
        case 5:
        {
            //identifier=@"sixthSegue";
            //ここにアラートを生成して表示させます
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"ログアウト"
                                  message:@"よろしいですか？"
                                  delegate:self
                                  cancelButtonTitle:@"はい" otherButtonTitles:@"いいえ", nil];
            [alert show];
            break;
        }
        default:
            break;
    }
    
    
    return identifier;
}

- (void)configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0,0};
    frame.size = (CGSize){40,40};
    
    button.frame = frame;
    [button setImage:[UIImage imageNamed:@"menuicon"] forState:UIControlStateNormal];
    
}

-(CGFloat)leftMenuWidth
{
    return 500;
}

//アラートボタンが押された時の処理メソッド
-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
        {
            //はいボタンが押されたときの処理を記述する
            //ログイン画面のStoryboard IDは"Login"です
        ViewController *ViewController2 = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self presentViewController:ViewController2 animated:YES completion:nil];
            break;
        }
        case 1:
            //いいえボタンが押されたときの処理を記述する
            break;
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
