//
//  drawRectView.m
//  gyoumuApp1
//
//  Created by Shota Oda on 2014/12/05.
//  Copyright (c) 2014年 shota. All rights reserved.
//

#import "drawRectView.h"

@implementation drawRectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init{
    self = [super init];
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    // グラフィックを取得
    CGContextRef g = UIGraphicsGetCurrentContext();
    
    // 白い四角
    /*
    CGContextSetRGBFillColor(g, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(g, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    */
    
    // 赤い四角
    /*
    CGContextSetRGBFillColor(g, 1.0, 0.0, 0.0, 1.0);
    CGContextFillRect(g, CGRectMake(self.frame.size.width*0.1, self.frame.size.height*0.1, self.frame.size.width*0.8, self.frame.size.height*0.8));
    */

    // 青い四角
    /*
    CGContextSetRGBFillColor(g, 0.0, 0.0, 1.0, 1.0);
    CGContextFillRect(g, CGRectMake(self.frame.size.width*0.2, self.frame.size.height*0.2, self.frame.size.width*0.6, self.frame.size.height*0.6));
    */
    // 黒線で×
    CGContextSetRGBStrokeColor(g, 0.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(g);
    CGContextMoveToPoint(g, 0, 0);
    CGContextAddLineToPoint(g, self.frame.size.width, self.frame.size.height);
    CGContextMoveToPoint(g, 0, 0);
    CGContextAddLineToPoint(g, 0, self.frame.size.height);
    CGContextClosePath(g);
    CGContextDrawPath(g, kCGPathStroke);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
