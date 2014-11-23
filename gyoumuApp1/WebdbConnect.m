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
    
    NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
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

-(id)initWithLabArray:(NSString *)labCode
{
    self = [super init];
    if (self) {
        NSString *urlList = [NSString stringWithFormat:@"http://webdb.per.c.fun.ac.jp/sofline%@/viewall.php",labCode];
        
        NSURLRequest *requestList = [NSURLRequest requestWithURL:[NSURL URLWithString:urlList]];
        NSData *jsonList = [NSURLConnection sendSynchronousRequest:requestList returningResponse:nil error:nil];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonList options:0 error:nil];
        NSArray *jsonArray = [jsonDic objectForKey:@"data"];
        _labArray = jsonArray;
    }
    return self;
}
@end
