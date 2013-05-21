//
//  TWDataController.h
//  Twote.io
//
//  Created by Marcus Kida on 21.05.13.
//  Copyright (c) 2013 Twote.io. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TWTwote.h"

@interface TWDataController : NSObject

+ (id) sharedInstance;

- (void) recentTwotesWithCompletion:(void(^)(BOOL success, NSArray *twotes))block;
- (void) twoteWithName:(NSString *)twoteName andCompletion:(void(^)(BOOL success, TWTwote *twote))block;

@end
