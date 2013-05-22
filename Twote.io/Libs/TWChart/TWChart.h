//
//  TWChart.h
//  Twote.io
//
//  Created by Marcus Kida on 21.05.13.
//  Copyright (c) 2013 Twote.io. All rights reserved.
//  Inspired by https://github.com/dhilipsiva/DSBarChart

#import <UIKit/UIKit.h>

@protocol TWChartDelegate <NSObject>

@optional
- (void) chartDidSelectButtonItemAtIndex:(NSInteger)index;

@end

@interface TWChart : UIView

-(TWChart * )initWithFrame:(CGRect)frame
                        color:(UIColor*)theColor
                   references:(NSArray *)references
                    andValues:(NSArray *)values;
@property (atomic) int numberOfBars;
@property (atomic) float maxLen;
@property (atomic, strong) UIColor *color;
@property (atomic) NSArray* vals;
@property (atomic) NSArray* refs;
@property (nonatomic) id <TWChartDelegate> delegate;

@end
