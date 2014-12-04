//
//  licenseDetail.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/24.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "licenseDetail.h"
#import "WebdbConnect.h"
#import "AppDelegate.h"

@implementation licenseDetail{
    NSMutableArray *_DetailSoftCollectArray;
    NSString *_maker;
    NSString *_software;
    NSString *_version;
    int countRow;
}

-(void) setLicendeDetail:(WebdbConnect *)connect
{
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _DetailSoftCollectArray = [NSMutableArray arrayWithArray:[connect labLicenseCodeGet:ap.softwareCode]];
}

-(NSMutableArray *) DetailSoftCollectArray{
    return _DetailSoftCollectArray;
}

-(NSString *) maker{
    return [_DetailSoftCollectArray[0] valueForKeyPath:@"option0"];
}

-(NSString *) software{
    return [_DetailSoftCollectArray[0] valueForKeyPath:@"option1"];
}

-(NSString *) version{
    return [_DetailSoftCollectArray[0] valueForKeyPath:@"option2"];
}

-(int) countRow{
    return (int)_DetailSoftCollectArray.count;
}

-(NSString *) identifier:(int)rowNum{
    return [_DetailSoftCollectArray[rowNum] valueForKeyPath:@"option3"];
}

-(NSString *) purchaseDate:(int)rowNum{
    return [_DetailSoftCollectArray[rowNum] valueForKeyPath:@"option5"];
}

-(NSString *) expirationDate:(int)rowNum{
    return [_DetailSoftCollectArray[rowNum] valueForKeyPath:@"option6"];
}

-(void) deleteLicense:(int)rowNum{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];

    NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],[_DetailSoftCollectArray[rowNum] valueForKeyPath:@"terminalId"], [_DetailSoftCollectArray[rowNum] valueForKeyPath:@"datetime"]];
    
    NSLog(@"%@",strURL);
    NSString *encodedString = [strURL stringByAddingPercentEscapesUsingEncoding:
                               NSUTF8StringEncoding];
    NSURL *urlDelete = [NSURL URLWithString:encodedString];
    
    NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
    
    [deleteRequest setHTTPMethod:@"GET"];
    
    [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
    
         
}
@end
