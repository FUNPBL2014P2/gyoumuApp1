//
//  licenseCollect.h
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/23.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebdbConnect.h"

@interface licenseCollect : NSObject

-(void) setLicenseArray:(WebdbConnect *)connect;
-(NSMutableArray *) licenseSortedArray;
-(NSMutableArray *) licenseSumArray;
-(int) countRow;
-(NSString *) maker:(int)rowNum;
-(NSString *) software:(int)rowNum;
-(NSString *) version:(int)rowNum;
-(NSString *) ownCount:(int)rowNum;
-(NSString *) softwareCode:(int)rowNum;
@end
