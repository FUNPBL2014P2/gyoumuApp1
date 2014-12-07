//
//  AppDelegate.h
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/10/15.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    //研究室一覧選択時のパス
    NSString *LabPath;
    NSString *softwareCode;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *LabPath;
@property (strong, nonatomic) NSString *softwareCode;
@property (strong, nonatomic) NSString *badgeTitle;
@end
