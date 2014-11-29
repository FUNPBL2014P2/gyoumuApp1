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

-(void)format{
    self.maker = NULL;
    self.software = NULL;
    self.version = NULL;
    self.tag = NULL;
    self.key = NULL;
    self.start = NULL;
    self.period = NULL;
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

-(BOOL)isDuplicatedTag:(NSString *)code :(NSString *)tag{
    WebdbConnect *labdb = [[WebdbConnect alloc]initWithLabArray:code];
    NSMutableArray *licenseArray = [[NSMutableArray alloc]init];
    licenseArray = [labdb labLicenseGet];
    for(int i=0;i<licenseArray.count;i++){
        if([[licenseArray[i] valueForKeyPath:@"option7"]isEqualToString:[NSString stringWithFormat:@"%@%@%@",self.maker,self.software,self.version]]){
            if([[licenseArray[i] valueForKeyPath:@"option3"]isEqualToString:tag]){
                return YES;
            }
        }
    }
    return NO;
}

@end
