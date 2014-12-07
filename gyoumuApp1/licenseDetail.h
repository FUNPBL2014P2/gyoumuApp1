//
//  licenseDetail.h
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/24.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebdbConnect.h"

@interface licenseDetail : NSObject

-(void) setLicendeDetail:(WebdbConnect *)connect;
-(NSMutableArray *) DetailSoftCollectArray;
-(NSString *) maker;
-(NSString *) software;
-(NSString *) version;
-(int) countRow;
-(NSString *) identifier:(int)rowNum;
-(NSString *) purchaseDate:(int)rowNum;
-(NSString *) expirationDate:(int)rowNum;
-(NSString *) busySet:(int)rowNum;
-(void)deleteLicense:(int)rowNum;
-(void) busyChange:(int)rowNum;
@end
