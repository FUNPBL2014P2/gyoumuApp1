//
//  additionData.h
//  gyoumuApp1
//
//  Created by SegawaTakamasa on 2014/11/19.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebdbConnect.h"

@interface additionData : NSObject
@property NSString *maker;
@property NSString *software;
@property NSString *version;
@property NSString *tag;
@property NSString *key;
@property NSString *start;
@property NSString *period;
@property WebdbConnect *Labdb;
@property BOOL isFromConfirm;
-(void)copy: (additionData *)target;
-(void)format;
-(void)debug;
-(BOOL)isDuplicatedTag:(NSString *)code :(NSString *)tag;
@end
