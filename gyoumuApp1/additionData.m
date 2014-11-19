//
//  additionData.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/19.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "additionData.h"



@implementation additionData
{
    NSString *maker;
    NSString *software;
    NSString *version;
    NSString *tag;
    NSString *key;
    NSDate *start;
    NSDate *period;
}


@synthesize maker;
@synthesize software;
@synthesize version;
@synthesize tag;
@synthesize key;
@synthesize start;
@synthesize period;

-(id)initWith:(NSString*)ma software:(NSString*)so version:(NSString*)ve tag:(NSString*)ta start:(NSDate*)st period:(NSDate*)pe
{
    if(self = [super init]){
        self->maker = ma;
        self->software = so;
        self->version = ve;
        self->tag = ta;
        self->start = st;
        self->period = pe;
    }
    return self;
}





@end

