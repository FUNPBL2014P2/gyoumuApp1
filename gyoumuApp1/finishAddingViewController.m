//
//  finishAddingViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/25.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "finishAddingViewController.h"
#import "WebdbConnect.h"
#import "additionData.h"

@interface finishAddingViewController ()
- (IBAction)againAdd:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *againBtn;

@end

@implementation finishAddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //leftBarButtonを削除する記述
    UIView* tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIBarButtonItem* tempButton = [[UIBarButtonItem alloc] initWithCustomView:tempView];
    tempButton.enabled = NO;
    self.navigationItem.leftBarButtonItem = tempButton;    // Do any additional setup after loading the view.
    
    
    if([self isAdded:self.addData]){
        self.message.text = @"ライセンス情報が登録されました。";
        [self.againBtn setTitle:@"別のライセンスを登録する" forState:UIControlStateNormal];
        [self.returnBtn setTitle:@"ライセンス一覧へ戻る" forState:UIControlStateNormal];
    }else{
        self.message.text = @"エラー：ライセンス情報が登録されませんでした。";
        [self.againBtn setTitle:@"初めからやり直す" forState:UIControlStateNormal];
        [self.returnBtn setTitle:@"ライセンス一覧へ戻る" forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.addData format];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)returnBtn:(id)sender {
}

-(BOOL)isAdded:(additionData *)checkArray{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    WebdbConnect *labDB = [[WebdbConnect alloc]initWithLabArray:[[userdefault objectForKey:@"userData"]valueForKeyPath:@"labCode"]];
    NSMutableArray *LicenseArray = [[NSMutableArray alloc]init];
    LicenseArray = [labDB labLicenseGet];
    NSLog(@"%@",LicenseArray);
    
    
    for(int i=0;i<LicenseArray.count;i++){
        if([[LicenseArray[i] valueForKeyPath:@"option0"] isEqualToString:checkArray.maker]&&
           [[LicenseArray[i] valueForKeyPath:@"option1"] isEqualToString:checkArray.software]&&
           [[LicenseArray[i] valueForKeyPath:@"option2"] isEqualToString:checkArray.version]&&
           [[LicenseArray[i] valueForKeyPath:@"option3"] isEqualToString:checkArray.tag]&&
           [[LicenseArray[i] valueForKeyPath:@"option4"] isEqualToString:checkArray.key]&&
           [[LicenseArray[i] valueForKeyPath:@"option5"] isEqualToString:checkArray.start]){
            return YES;
        }
    }
    return NO;
}

- (IBAction)againAdd:(id)sender {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:NO];
}
@end
