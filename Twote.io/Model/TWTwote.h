//
//  TWTwote.h
//  Twote.io
//
//  Created by Marcus Kida on 21.05.13.
//  Copyright (c) 2013 Twote.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWTwote : NSObject

@property (nonatomic, retain) NSString *twote;
@property (nonatomic, retain) NSNumber *overallVotes;
@property (nonatomic, retain) NSDictionary *votes;

@end
