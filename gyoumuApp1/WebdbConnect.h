//
//  WebdbConnect.h
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/17.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebdbConnect : NSObject
- (void)setLabArray:(NSString *)labCode;
-(NSArray *)labArray;
-(NSObject *)labBadgeGet:(NSString *)badgeTitle;

-(id)initWithLabArray:(NSString *)labCode;

@end
