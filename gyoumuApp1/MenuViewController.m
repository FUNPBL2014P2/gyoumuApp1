//
//  MenuViewController.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/10/17.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "MenuViewController.h"

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
        case 0:
            identifier=@"firstSegue";
            break;
            
        case 1:
            identifier=@"secondSegue";
            break;

        default:
            break;
    }
    
    
    return identifier;
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
