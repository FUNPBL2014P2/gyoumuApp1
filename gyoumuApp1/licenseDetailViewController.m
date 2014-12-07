//
//  licenseDetailViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/23.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "licenseDetailViewController.h"
#import "WebdbConnect.h"
#import "AppDelegate.h"
#import "licenseDetail.h"

@interface licenseDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *makerLabel;
@property (weak, nonatomic) IBOutlet UILabel *softwareLabel;
@property (weak, nonatomic) IBOutlet UILabel *verLabel;

//self.tableViewを使うための宣言
@property (weak, nonatomic) IBOutlet UITableView *tableLD;

@end

@implementation licenseDetailViewController
{
    licenseDetail *ld;
    //チェックマークのついてるテーブルのセル番号
    int row;
    UIAlertView *deleteAlert;
    UIAlertView *busyAlert;
    UIAlertView *nobusyAlert;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *userdata = [userDefaults objectForKey:@"userData"];
    WebdbConnect *connect = [[WebdbConnect alloc] initWithLabArray:[userdata valueForKeyPath:@"labCode"]];
    //[connect labLicenseCodeGet:softReceiveData];
    ld = [[licenseDetail alloc] init];
    [ld setLicendeDetail:connect];
    
    self.makerLabel.text = ld.maker;
    self.softwareLabel.text = ld.software;
    self.verLabel.text = ld.version;
    // Do any additional setup after loading the view.
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteBtn.frame = CGRectMake(691, 76, 46, 30);
    [deleteBtn setTitle:@"削除" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteCall:)
  forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:deleteBtn];
    
    UIButton *busyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    busyBtn.frame = CGRectMake(691, 107, 46, 30);
    [busyBtn setTitle:@"使用" forState:UIControlStateNormal];
    [busyBtn addTarget:self action:@selector(busyCell:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:busyBtn];

}


// 呼ばれるdeleteCallメソッド
-(void)deleteCall:(UIButton*)button{
    // テーブルがチェックされてたら
    if (row > 0) {
        NSLog(@"%d番目", row);
        // １行で書くタイプ（複数ボタンタイプ）
        deleteAlert =
        [[UIAlertView alloc] initWithTitle:@"確認" message:@"削除してもよろしいですか？"
                                  delegate:self cancelButtonTitle:@"いいえ" otherButtonTitles:@"はい", nil];
        [deleteAlert show];
    } else
    {
        NSLog(@"no select");
    }
    
    // FavoriteViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FavoriteViewController"];
    
}

-(void)busyCell:(UIButton*)button{
    // テーブルがチェックされてたら
    if (row > 0) {
        NSLog(@"%d番目", row);
        // １行で書くタイプ（複数ボタンタイプ）
        if ([[ld busySet:row-1] isEqualToString:@"×"]) {
            busyAlert =
            [[UIAlertView alloc] initWithTitle:@"確認" message:@"使用中にしてもよろしいですか？"
                                      delegate:self cancelButtonTitle:@"いいえ" otherButtonTitles:@"はい", nil];
            [busyAlert show];

        } else {
            nobusyAlert =
            [[UIAlertView alloc] initWithTitle:@"確認" message:@"使用中を解除してもよろしいですか？"
                                      delegate:self cancelButtonTitle:@"いいえ" otherButtonTitles:@"はい", nil];
            [nobusyAlert show];

        }
            } else
        NSLog(@"no select");
    

}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (deleteAlert == alertView) {
        
    switch (buttonIndex) {
        case 0:
            //いいえボタンが押されたときの処理を記述する
            NSLog(@"canceled");
            break;
        case 1:
            //はいボタンが押されたときの処理を記述する
            NSLog(@"delete");
            [ld deleteLicense:row-1];
            //削除後、データベースを更新
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSArray *userdata = [userDefaults objectForKey:@"userData"];
            WebdbConnect *connect = [[WebdbConnect alloc] initWithLabArray:[userdata valueForKeyPath:@"labCode"]];
            //[connect labLicenseCodeGet:softReceiveData];
            ld = [[licenseDetail alloc] init];
            [ld setLicendeDetail:connect];
            //テーブルを更新
            UITableViewCell *cellDouble = [self.tableLD cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:0]];
            cellDouble.accessoryType = UITableViewCellAccessoryNone;
            [self.tableLD reloadData];
            row = 0;
            UIAlertView *alert =
            [[UIAlertView alloc] initWithTitle:@"Deleted" message:@"削除が完了しました"
                                      delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
            [alert show];
            
            break;
      }
        //使用ボタン-使用中にする-
    } else if (busyAlert == alertView) {
        
        switch (buttonIndex) {

    case 0:
        //いいえボタンが押されたときの処理を記述する
        NSLog(@"canceled");
        break;
    case 1:
        //はいボタンが押されたときの処理を記述する
        [ld busyChange:row-1];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                NSArray *userdata = [userDefaults objectForKey:@"userData"];
                WebdbConnect *connect = [[WebdbConnect alloc] initWithLabArray:[userdata valueForKeyPath:@"labCode"]];
                //[connect labLicenseCodeGet:softReceiveData];
                ld = [[licenseDetail alloc] init];
                [ld setLicendeDetail:connect];
                //テーブルを更新
                UITableViewCell *cellDouble = [self.tableLD cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:0]];
                cellDouble.accessoryType = UITableViewCellAccessoryNone;
                [self.tableLD reloadData];
                row = 0;
                
                UIAlertView *alert =
                [[UIAlertView alloc] initWithTitle:@"It's being used" message:@"使用中になりました"
                                          delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
                [alert show];

        break;
        }
        
    }
    ////使用ボタン-使用中を解除にする-
    else if (nobusyAlert == alertView) {
        switch (buttonIndex) {
                
            case 0:
                //いいえボタンが押されたときの処理を記述する
                NSLog(@"canceled");
                break;
            case 1:
                //はいボタンが押されたときの処理を記述する
                [ld busyChange:row-1];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                NSArray *userdata = [userDefaults objectForKey:@"userData"];
                WebdbConnect *connect = [[WebdbConnect alloc] initWithLabArray:[userdata valueForKeyPath:@"labCode"]];
                //[connect labLicenseCodeGet:softReceiveData];
                ld = [[licenseDetail alloc] init];
                [ld setLicendeDetail:connect];
                //テーブルを更新
                UITableViewCell *cellDouble = [self.tableLD cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:0]];
                cellDouble.accessoryType = UITableViewCellAccessoryNone;
                [self.tableLD reloadData];
                row = 0;
                
                UIAlertView *alert =
                [[UIAlertView alloc] initWithTitle:@"It's being unused" message:@"使用中を解除しました"
                                          delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
                [alert show];

                break;

       }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView

{
    return 1;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //同名ソフトウェアの数
    return ld.countRow;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    } else
        cell.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellDouble = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    
    if ( (cellDouble.accessoryType == UITableViewCellAccessoryCheckmark) && (indexPath.row == row-1)) {
        cellDouble.accessoryType = UITableViewCellAccessoryNone;
        row = 0;
        return ;
    }
   
    // テーブルのセルに１つだけチェックマークをつける処理
    // ②選択したセル以外のすべてのチェックを取る
    // 今回はセクションは「０」（一番初めのセクション）とします。
    for (NSInteger index=0; index<[tableView numberOfRowsInSection:0]; index++) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        // ①選択したセルだけチェックする
        if (indexPath.row == index) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            row = (int)indexPath.row+1;
        }
    }
}



-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"softwareCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    UILabel *label1 = (UILabel *)[cell viewWithTag:1];
    label1.text = [NSString stringWithFormat:@"%@",[ld identifier:(int)indexPath.row]];
    UILabel *label2 = (UILabel *)[cell viewWithTag:2];
    label2.text = [NSString stringWithFormat:@"%@",[ld purchaseDate:(int)indexPath.row]];
    UILabel *label3 = (UILabel *)[cell viewWithTag:3];
    label3.text = [NSString stringWithFormat:@"%@",[ld expirationDate:(int)indexPath.row]];
    UILabel *label4 = (UILabel *)[cell viewWithTag:4];
    label4.text = [NSString stringWithFormat:@"%@",[ld busySet:(int)indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
    
}



@end
