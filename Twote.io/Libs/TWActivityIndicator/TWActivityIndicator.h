//
//  TWActivityIndicator.h
//  Twote.io
//
//  Created by Marcus Kida on 21.05.13.
//  Copyright (c) 2013 Twote.io. All rights reserved.
//  Inspired by https://github.com/raweng/gmail-like-loading

#import <UIKit/UIKit.h>

@interface TWActivityIndicator : UIView

+ (id) sharedInstance;
-(void)startAnimating;
-(void)stopAnimating;

@property (nonatomic) BOOL isAnimating;

@end