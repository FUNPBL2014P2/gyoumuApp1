//
//  licenseTableViewController.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/20.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "licenseTableViewController.h"
#import "WebdbConnect.h"
#import "AppDelegate.h"
#import "licenseCollect.h"

@interface licenseTableViewController () <UITableViewDataSource,UITableViewDelegate>

// self.tableViewを使うための宣言
@property (weak, nonatomic) IBOutlet UITableView *LT;

@end

@implementation licenseTableViewController
{
    licenseCollect *lc;
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
    
    //for (int i = 0; i < [connect labArray].count; i++) {
    
    //}
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    //詳細から戻った際もテーブルを更新するようにした
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *userdata = [userDefaults objectForKey:@"userData"];
    WebdbConnect *connect = [[WebdbConnect alloc] initWithLabArray:[userdata valueForKeyPath:@"labCode"]];
    
    lc = [[licenseCollect alloc] init];
    [lc setLicenseArray:connect];
    [self evaluateRecieveCheck:5 :@"07"];
    //テーブル更新
    [self.LT reloadData];
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
    return lc.countRow;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    } else
        cell.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ap.softwareCode =[lc softwareCode:(int)indexPath.row];
    [self performSegueWithIdentifier:@"licenseDetail" sender:self];
    
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"myCell2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    UILabel *label1 = (UILabel *)[cell viewWithTag:1];
    label1.text = [NSString stringWithFormat:@"%@",[lc maker:(int)indexPath.row]];
    UILabel *label2 = (UILabel *)[cell viewWithTag:2];
    label2.text = [NSString stringWithFormat:@"%@",[lc software:(int)indexPath.row]];
    UILabel *label3 = (UILabel *)[cell viewWithTag:3];
    label3.text = [NSString stringWithFormat:@"%@",[lc version:(int)indexPath.row]];
    UILabel *label4 = (UILabel *)[cell viewWithTag:4];
    label4.text = [NSString stringWithFormat:@"%@", [lc ownCount:(int)indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}

-(IBAction)returnMain3:(UIStoryboardSegue *)sender
{
    
}
-(void) licenseCheck:(int) flagCount :(NSString *) badgeTitle
{
    //Viewall用
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    WebdbConnect *myLab = [[WebdbConnect alloc] initWithLabArray:[userData valueForKeyPath:@"labCode"]];
    NSObject *jsonArray =[myLab labBadgeGet:badgeTitle];
    
    if ( [[jsonArray valueForKeyPath:@"option0"] isEqualToString:@"1"]) {
        return;
    }
    int count = [[jsonArray valueForKeyPath:@"option2"] intValue] + 1;
    
    if (count == flagCount) {
        
        /////////////////取得日時
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        [fmt setDateFormat:@"yyyy年MM月dd日 HH時mm分"];
        NSDate *nowGet = [[NSDate alloc]init];
        
        /////////////////////取得日時を送信する処理
        
        NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
        NSURL *url = [NSURL URLWithString:urlList];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        //パラメータを作成
        
        NSString *body =[NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=1&option1=%@&option2=%@&option3=%@&option4=%@&option5=%@",[jsonArray valueForKeyPath:@"title"],[jsonArray valueForKeyPath:@"terminalId"],[fmt stringFromDate:nowGet],[NSString stringWithFormat:@"%d",flagCount], [jsonArray valueForKeyPath:@"option3"],[jsonArray valueForKeyPath:@"option4"],[jsonArray valueForKeyPath:@"option5"]];
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSURLConnection *connection;
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        //////////////////
        
        NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],[jsonArray valueForKeyPath:@"terminalId"], [jsonArray valueForKeyPath:@"datetime"]];
        NSURL *urlDelete = [NSURL URLWithString:strURL];
        NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
        [deleteRequest setHTTPMethod:@"GET"];
        [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
        
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"バッジ取得" message:[jsonArray valueForKeyPath:@"option3"]delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return ;
   
    }else if (count < flagCount) {
        
        NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
        NSURL *url = [NSURL URLWithString:urlList];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        //パラメータを作成
        
        NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=0&option1=&option2=%d&option3=%@&option4=%@&option5=%@",[jsonArray valueForKeyPath:@"title"],[jsonArray valueForKeyPath:@"terminalId"],count,[jsonArray valueForKeyPath:@"option3"],[jsonArray valueForKeyPath:@"option4"],[jsonArray valueForKeyPath:@"option5"]];
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSURLConnection *connection;
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        /////////////////////
        
        NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],[jsonArray valueForKeyPath:@"terminalId"], [jsonArray valueForKeyPath:@"datetime"]];
        NSURL *urlDelete = [NSURL URLWithString:strURL];
        NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
        [deleteRequest setHTTPMethod:@"GET"];
        [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
        
        ///////////////////
        //削除したら抜ける
        return ;
        /////////////////////
    }
}

-(void) evaluateRecieveCheck:(int) flagCount :(NSString *) badgeTitle
{
    //Viewall用
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    WebdbConnect *myLab = [[WebdbConnect alloc] initWithLabArray:[userData valueForKeyPath:@"labCode"]];
    NSObject *jsonArray = [myLab labBadgeGet:badgeTitle];
    
    if ( [[jsonArray valueForKeyPath:@"option0"] isEqualToString:@"1"]) {
        return;
    }
    int count = [[[myLab labEvaluateGet]valueForKeyPath:@"option3"] intValue];
    
    if (count >= flagCount) {
        
        /////////////////取得日時
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        [fmt setDateFormat:@"yyyy年MM月dd日 HH時mm分"];
        NSDate *nowGet = [[NSDate alloc]init];
        
        /////////////////////取得日時を送信する処理
        
        NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
        NSURL *url = [NSURL URLWithString:urlList];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        //パラメータを作成
        
        NSString *body =[NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=1&option1=%@&option2=%@&option3=%@&option4=%@&option5=%@",[jsonArray valueForKeyPath:@"title"],[jsonArray valueForKeyPath:@"terminalId"],[fmt stringFromDate:nowGet],[NSString stringWithFormat:@"%d",flagCount], [jsonArray valueForKeyPath:@"option3"],[jsonArray valueForKeyPath:@"option4"],[jsonArray valueForKeyPath:@"option5"]];
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSURLConnection *connection;
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        //////////////////
        
        NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],[jsonArray valueForKeyPath:@"terminalId"], [jsonArray valueForKeyPath:@"datetime"]];
        NSURL *urlDelete = [NSURL URLWithString:strURL];
        NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
        [deleteRequest setHTTPMethod:@"GET"];
        [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"バッジ取得" message:[jsonArray valueForKeyPath:@"option3"]delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return ;
        
    }else if (count < flagCount) {
        
        NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
        NSURL *url = [NSURL URLWithString:urlList];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        
        //パラメータを作成
        
        NSString *body = [NSString stringWithFormat:@"title=%@&message=&latitude=&longitude=&terminalId=%@&option0=0&option1=&option2=%d&option3=%@&option4=%@&option5=%@",[jsonArray valueForKeyPath:@"title"],[jsonArray valueForKeyPath:@"terminalId"],count,[jsonArray valueForKeyPath:@"option3"],[jsonArray valueForKeyPath:@"option4"],[jsonArray valueForKeyPath:@"option5"]];
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSURLConnection *connection;
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        /////////////////////
        
        NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],[jsonArray valueForKeyPath:@"terminalId"], [jsonArray valueForKeyPath:@"datetime"]];
        NSURL *urlDelete = [NSURL URLWithString:strURL];
        NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
        [deleteRequest setHTTPMethod:@"GET"];
        [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
        
        return ;
    }
}

    /*
     - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
     {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
     
     // Configure the cell...
     
     return cell;
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
     {
     // Return NO if you do not want the specified item to be editable.
     return YES;
     }
     */
    
    /*
     // Override to support editing the table view.
     - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
     {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
     // Delete the row from the data source
     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     } else if (editingStyle == UITableViewCellEditingStyleInsert) {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
     {
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
     {
     // Return NO if you do not want the item to be re-orderable.
     return YES;
     }
     */
    
    /*
     #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
     {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    @end
