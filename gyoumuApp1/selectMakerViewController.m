//
//  selectMakerViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "selectMakerViewController.h"
#import "selectSoftwareViewController.h"
#import "additionData.h"
#import "WebdbConnect.h"

@interface selectMakerViewController ()

@end

@implementation selectMakerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [user objectForKey:@"userData"];
    
    self.addData = [[additionData alloc]init];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    WebdbConnect *master = [[WebdbConnect alloc]initWithLabArray:[userData valueForKeyPath:@"labCode"]];
    self.masterArray = [[NSMutableArray alloc]init];
    self.masterArray = [master labMasterGet];
    
    self.makerArray = [[NSArray alloc]init];
    self.makerArray = [self detectMaker:self.masterArray];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // セルの数になる
    return self.makerArray.count;
}
/*
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
*/
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"makerCell" forIndexPath:indexPath];
    
    UILabel *softwareName = (UILabel *)[cell viewWithTag:1];
    softwareName.text = [self.makerArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *targetCell = (UILabel *)[cell viewWithTag:1];
    self.addData.maker = targetCell.text;
    NSLog(@"%@",self.addData.maker);
    [self performSegueWithIdentifier:@"maker" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    selectSoftwareViewController *nextVC = segue.destinationViewController;
    nextVC.addData = [[additionData alloc]init];
    [nextVC.addData copy:self.addData];
}

- (NSArray *)detectMaker:(NSMutableArray *)array{
    NSMutableSet *makerSet = [NSMutableSet set];
    for(int i=0;i<array.count;i++){
            [makerSet addObject:[array[i] valueForKeyPath:@"option0"]];
    }
    NSArray *softwareArray = [makerSet allObjects];
    return softwareArray;
}

@end