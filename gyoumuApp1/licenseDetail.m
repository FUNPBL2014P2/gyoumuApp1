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
    NSString *_busy;
    int countRow;
    NSString *_softTag;
}

-(void) setLicendeDetail:(WebdbConnect *)connect
{
    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _DetailSoftCollectArray = [NSMutableArray arrayWithArray:[connect labLicenseCodeGet:ap.softwareCode]];
    if (_DetailSoftCollectArray.count == 0) {
        return;
    } else{
    _maker = [_DetailSoftCollectArray[0] valueForKeyPath:@"option0"];
    _software= [_DetailSoftCollectArray[0] valueForKeyPath:@"option1"];
    _version = [_DetailSoftCollectArray[0] valueForKeyPath:@"option2"];
    _softTag = [_DetailSoftCollectArray[0] valueForKeyPath:@"option7"];
    }
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


-(NSString *) softTag{
    return [_DetailSoftCollectArray[0] valueForKeyPath:@"option7"];
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

-(NSString *) busySet:(int)rowNum{
    NSString *noBusy = @"";
    if ([[_DetailSoftCollectArray[rowNum] valueForKeyPath:@"message"] isEqualToString:noBusy]) {
        return @"×";
    }
    return @"◯";
}

-(void) busyChange:(int)rowNum{
    NSString *busyAdd;
    if ([[_DetailSoftCollectArray[rowNum] valueForKeyPath:@"message"] isEqualToString:@""]) {
         busyAdd = @"◯";
    } else if ([[_DetailSoftCollectArray[rowNum] valueForKeyPath:@"message"] isEqualToString:@"◯"])
    {
        busyAdd = @"";
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userData = [userDefaults objectForKey:@"userData"];
    NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/add.php",[userData valueForKeyPath:@"labCode"]];
    
    NSURL *url = [NSURL URLWithString:urlList];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    //パラメータを作成
    NSString *body = [NSString stringWithFormat:@"title=ライセンス&message=%@&latitude=&longitude=&terminalId=ライセンス&option0=%@&option1=%@&option2=%@&option3=%@&option4=%@&option5=%@&option6=%@&option7=%@",busyAdd,_maker,_software,_version,[_DetailSoftCollectArray[rowNum] valueForKeyPath:@"option3"],[_DetailSoftCollectArray[rowNum] valueForKeyPath:@"option4"], [_DetailSoftCollectArray[rowNum] valueForKeyPath:@"option5"], [_DetailSoftCollectArray[rowNum] valueForKeyPath:@"option6"],
                      _softTag];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSURLConnection *connection;
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //////////////////////////////////////////
    NSString *strURL = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/delete.php?data=/%@/%@",[userData valueForKeyPath:@"labCode"],[_DetailSoftCollectArray[rowNum] valueForKeyPath:@"terminalId"], [_DetailSoftCollectArray[rowNum] valueForKeyPath:@"datetime"]];
    
    NSLog(@"%@",strURL);
    NSString *encodedString = [strURL stringByAddingPercentEscapesUsingEncoding:
                               NSUTF8StringEncoding];
    NSURL *urlDelete = [NSURL URLWithString:encodedString];
    
    NSMutableURLRequest *deleteRequest = [NSMutableURLRequest requestWithURL:urlDelete];
    
    [deleteRequest setHTTPMethod:@"GET"];
    
    [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:nil error:nil];
    
    
    
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
