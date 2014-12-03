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
    deleteBtn.frame = CGRectMake(516, 218, 100, 30);
    [deleteBtn setTitle:@"削除" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteCall:)
  forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:deleteBtn];
    

}


// 呼ばれるdeleteCallメソッド
-(void)deleteCall:(UIButton*)button{
    // テーブルがチェックされてたら
    if (row > 0) {
        NSLog(@"%d番目", row);
        // １行で書くタイプ（複数ボタンタイプ）
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"確認" message:@"削除してもよろしいですか？"
                                  delegate:self cancelButtonTitle:@"いいえ" otherButtonTitles:@"はい", nil];
        [alert show];
    } else
    {
        NSLog(@"no select");
    }
    
    // FavoriteViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FavoriteViewController"];
    
}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //１番目のボタンが押されたときの処理を記述する
            NSLog(@"canceled");
            break;
        case 1:
            //２番目のボタンが押されたときの処理を記述する
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
            [self.tableLD reloadData];
            UIAlertView *alert =
            [[UIAlertView alloc] initWithTitle:@"Deleted" message:@"削除が完了しました"
                                      delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
            [alert show];

            break;
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
   
    // テーブルのセルに１つだけチェックマークをつける処理
    // ②選択したセル以外のすべてのチェックを取る
    // 今回はセクションは「０」（一番初めのセクション）とします。
    for (NSInteger index=0; index<[tableView numberOfRowsInSection:0]; index++) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        // ①選択したセルだけチェックする
        if (indexPath.row == index) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            row = indexPath.row+1;
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
    
}



@end
