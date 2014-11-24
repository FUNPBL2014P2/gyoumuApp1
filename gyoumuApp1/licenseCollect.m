//
//  licenseCollect.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/11/23.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "licenseCollect.h"
#import "WebdbConnect.h"

@implementation licenseCollect
{
    NSMutableArray *_licenseSortedArray;
    NSMutableArray *_licenseSumArray;
    //NSArray *_sortedArray;
    int countRow;
}

-(void) setLicenseArray:(WebdbConnect *)connect
{
    _licenseSumArray = [NSMutableArray array];
    _licenseSortedArray = [NSMutableArray array];
    NSArray *sortedArray ;
    NSMutableArray  *licenseArrayTset = [NSMutableArray arrayWithArray:[connect labLicenseGet]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"option7" ascending:YES];
    sortedArray = [licenseArrayTset sortedArrayUsingDescriptors:@[sortDescriptor]];
    NSString *comp = @"init";
    int softCount = 0;
    
    for (int i = 0; i < sortedArray.count; i++) {
        
        if (![comp isEqualToString:[sortedArray[i] valueForKeyPath:@"option7"]]) {
            comp = [sortedArray[i]valueForKeyPath:@"option7"];
            for (int j = i; j < sortedArray.count; j++) {
                if ([comp isEqualToString:[sortedArray[j] valueForKeyPath:@"option7"]]) {
                    softCount++;
                }
                
            }
            [_licenseSumArray addObject:[NSString stringWithFormat:@"%d",softCount]];
            [_licenseSortedArray addObject:sortedArray[i]];
            softCount = 0;
            
        }
    }

}

-(NSMutableArray *) licenseSortedArray
{
    return  _licenseSortedArray;
}

-(NSMutableArray *) licenseSumArray
{
    return _licenseSumArray;
}

-(int) countRow
{
    return (int)_licenseSumArray.count;
}

-(NSString *) maker:(int)rowNum{
    return [_licenseSortedArray[rowNum] valueForKeyPath:@"option0"];
}

-(NSString *) software:(int)rowNum{
    return [_licenseSortedArray[rowNum] valueForKeyPath:@"option1"];
}

-(NSString *) version:(int)rowNum{
    return [_licenseSortedArray[rowNum] valueForKeyPath:@"option2"];
}

-(NSString *) ownCount:(int)rowNum{
    return _licenseSumArray[rowNum];
}

-(NSString *) softwareCode:(int)rowNum{
    return [_licenseSortedArray[rowNum] valueForKeyPath:@"option7"];
}
//-(void)setSoftArray:
@end
