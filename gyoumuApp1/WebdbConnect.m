//
//  WebdbConnect.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/17.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "WebdbConnect.h"

@implementation WebdbConnect
{
    NSArray *_labArray;
}

-(void)setLabArray:(NSString *)labCode
{
    NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/viewall.php",labCode];
    
    NSMutableURLRequest *requestList = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlList]];
    [requestList setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];

    NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
    NSArray *jsonArray = [jsonDic objectForKey:@"data"];

    _labArray = jsonArray;
}

-(NSArray *)labArray
{
    return _labArray;
}

//badgeのタイトルと一致する情報を返す
-(NSObject *)labBadgeGet:(NSString *)badgeTitle
{
    for (int i = 0; i < _labArray.count; i++) {
        if ([_labArray[i][@"terminalId"] isEqualToString:[NSString stringWithFormat:@"badge%@",badgeTitle]]) {
            return _labArray[i];
        }
    }
    return nil;
}

-(NSObject *)labEvaluateGet
{
    for (int i = 0; i < _labArray.count; i++) {
        if ([_labArray[i][@"terminalId"] isEqualToString:@"Evaluate"]) {
            return _labArray[i];
        }
    }
    return nil;
}

-(NSMutableArray *)labMasterGet
{
    NSMutableArray* masterArray = [[NSMutableArray alloc]init];
    
        for (int i = 0; i < _labArray.count; i++) {
                if ([_labArray[i][@"terminalId"] isEqualToString:@"マスタ"]) {
                    [masterArray addObject:_labArray[i]];
                }
        }
        return masterArray;
}

-(NSMutableArray *)labBadgeAllGet
{
    NSMutableArray* badgeArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _labArray.count; i++) {
        NSString *terminal_badge = [_labArray[i][@"terminalId"] substringWithRange:NSMakeRange(0, 3)];
        if ([terminal_badge isEqualToString:@"bad"]) {
            [badgeArray addObject:_labArray[i]];
        }
    }
    return badgeArray;
}


-(id)initWithLabArray:(NSString *)labCode
{
    self = [super init];
    if (self) {
        NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/viewall.php",labCode];
        
        NSMutableURLRequest *requestList = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlList]];
        [requestList setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];

        NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
        NSArray *jsonArray = [jsonDic objectForKey:@"data"];
        _labArray = jsonArray;
    }
    return self;
}

-(NSMutableArray *)labLicenseGet
{
    NSMutableArray* licenseArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _labArray.count; i++) {
        if ([_labArray[i][@"terminalId"] isEqualToString:@"ライセンス"]) {
            [licenseArray addObject:_labArray[i]];
        }
    }
    return licenseArray;
}


-(NSMutableArray *)labLicenseCodeGet:(NSString *)code
{
    NSMutableArray* licenseArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _labArray.count; i++) {
        if ([_labArray[i][@"option7"] isEqualToString:code]) {
            [licenseArray addObject:_labArray[i]];
        }
    }
    return licenseArray;
}

@end
