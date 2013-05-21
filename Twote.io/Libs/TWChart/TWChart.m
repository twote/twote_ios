//
//  TWChart.m
//  Twote.io
//
//  Created by Marcus Kida on 21.05.13.
//  Copyright (c) 2013 Twote.io. All rights reserved.
//  Inspired by https://github.com/dhilipsiva/DSBarChart

#import "TWChart.h"

@implementation TWChart
@synthesize color, numberOfBars, maxLen, refs, vals;

-(TWChart *)initWithFrame:(CGRect)frame
                       color:(UIColor *)theColor
                  references:(NSArray *)references
                   andValues:(NSArray *)values
{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = theColor;
        self.vals = values;
        self.refs = references;
    }
    return self;
}

-(void)calculate{
    self.numberOfBars = [self.vals count];
    for (NSNumber *val in vals) {
        float iLen = [val floatValue];
        if (iLen > self.maxLen) {
            self.maxLen = iLen;
        }
    }
}

- (void)drawRect:(CGRect)rect
{
    /// Drawing code
    [self calculate];
    float rectWidth = (float)(rect.size.width-(self.numberOfBars)) / (float)self.numberOfBars;
    CGContextRef context = UIGraphicsGetCurrentContext();
    float LBL_HEIGHT = 20.0f, iLen, x, heightRatio, height, y;
    UIColor *iColor ;
    
    /// Draw Bars
    for (int barCount = 0; barCount < self.numberOfBars; barCount++) {
        
        /// Calculate dimensions
        iLen = [[vals objectAtIndex:barCount] floatValue];
        x = barCount * (rectWidth);
        heightRatio = iLen / self.maxLen;
        height = heightRatio * rect.size.height;
        if (height < 0.1f) height = 1.0f;
        y = rect.size.height - height - LBL_HEIGHT;
        
        /// Reference Label.
        UILabel *lblRef = [[UILabel alloc] initWithFrame:CGRectMake(barCount + x, rect.size.height - LBL_HEIGHT, rectWidth, LBL_HEIGHT)];
        lblRef.text = [[refs objectAtIndex:barCount] uppercaseString];
        lblRef.adjustsFontSizeToFitWidth = TRUE;
        lblRef.adjustsLetterSpacingToFitWidth = TRUE;
        lblRef.textColor = self.color;
        [lblRef setTextAlignment:NSTextAlignmentCenter];
        lblRef.backgroundColor = [UIColor clearColor];
        lblRef.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:18.0f];
        [self addSubview:lblRef];
        
        /// Set color and draw the bar
        iColor = [UIColor colorWithRed:0.910 green:0.808 blue:0.247 alpha:1.000];
        CGContextSetFillColorWithColor(context, iColor.CGColor);
        CGRect barRect = CGRectMake(barCount + x, y, rectWidth, height);
        CGContextFillRect(context, barRect);
    }
    
    /// pivot
    CGRect frame = CGRectZero;
    frame.origin.x = rect.origin.x;
    frame.origin.y = rect.origin.y - LBL_HEIGHT;
    frame.size.height = LBL_HEIGHT;
    frame.size.width = rect.size.width;
    UILabel *pivotLabel = [[UILabel alloc] initWithFrame:frame];
    pivotLabel.text = [NSString stringWithFormat:@"%d", (int)self.maxLen];
    pivotLabel.backgroundColor = [UIColor clearColor];
    pivotLabel.textColor = self.color;
    pivotLabel.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:18.0f];
    [self addSubview:pivotLabel];
    
    /// A line
    frame = rect;
    frame.size.height = 1.0;
    CGContextSetFillColorWithColor(context, self.color.CGColor);
    CGContextFillRect(context, frame);
}


@end
