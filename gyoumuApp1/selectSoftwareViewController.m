//
//  selectSoftwareViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "selectSoftwareViewController.h"
#import "selectVersionViewController.h"
#import "WebdbConnect.h"

@interface selectSoftwareViewController ()

@end

@implementation selectSoftwareViewController
@synthesize  masterArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [user objectForKey:@"userData"];
    
    WebdbConnect *master = [[WebdbConnect alloc]initWithLabArray:[userData valueForKeyPath:@"labCode"]];
    self.masterArray = [[NSMutableArray alloc]init];
    self.masterArray = [master labMasterGet];
    
    self.softwareArray = [[NSArray alloc]init];
    self.softwareArray = [self detectSoftware:self.masterArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // セルの数になる
    return self.softwareArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"softwareCell" forIndexPath:indexPath];
    
    UILabel *softwareName = (UILabel *)[cell viewWithTag:1];
    softwareName.text = [self.softwareArray objectAtIndex:indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *targetCell = (UILabel *)[cell viewWithTag:1];
    self.addData.software = targetCell.text;
    [self performSegueWithIdentifier:@"software" sender:self];
}

//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        selectVersionViewController *nextVC = segue.destinationViewController;
        nextVC.addData = [[additionData alloc]init];
        [nextVC.addData copy:self.addData];
        nextVC.masterArray = [self.masterArray mutableCopy];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (NSArray *)detectSoftware:(NSMutableArray *)array{
    NSMutableSet *softwareSet = [NSMutableSet set];
    for(int i=0;i<array.count;i++){
        if([self.addData.maker isEqualToString:[array[i] valueForKeyPath:@"option0"]]){
            [softwareSet addObject:[array[i] valueForKeyPath:@"option1"]];
        }
    }
    NSArray *softwareArray = [softwareSet allObjects];
    return softwareArray;
}

@end
