//
//  selectMakerViewController.h
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "additionData.h"

@interface selectMakerViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    additionData *_addData;
    UITableView *_tableView;
}

@property additionData *addData;
@property IBOutlet UITableView *tableView;
@property NSMutableArray *masterArray;
@property NSArray *makerArray;
@end
