//
//  additionData.m
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/19.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "additionData.h"

@implementation additionData

-(void)copy: (additionData *)target{
    self.maker = target.maker;
    self.software = target.software;
    self.version = target.version;
    self.tag = target.tag;
    self.key = target.key;
    self.start = target.start;
    self.period = target.period;
}

-(void)debug{
    NSLog(@"Maker :%@",self.maker);
    NSLog(@"Software :%@",self.software);
    NSLog(@"Version :%@",self.version);
    NSLog(@"Tag :%@",self.tag);
    NSLog(@"Key :%@",self.key);
    NSLog(@"Start :%@",self.start);
    NSLog(@"Period :%@",self.period);
}

@end
