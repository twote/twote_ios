//
//  TWDataController.m
//  Twote.io
//
//  Created by Marcus Kida on 21.05.13.
//  Copyright (c) 2013 Twote.io. All rights reserved.
//

#import "TWDataController.h"

@implementation TWDataController

+ (id) sharedInstance
{
    static TWDataController *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[TWDataController alloc] init];
    });
    return _sharedInstance;
}

- (void) recentTwotesWithCompletion:(void(^)(BOOL success, NSArray *twotes))block
{
    NSURL *url = [NSURL URLWithString:@"http://twote.io/twote"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSMutableArray *twotes = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in [JSON objectForKey:@"result"])
        {
            TWTwote *twote = [[TWTwote alloc] init];
            twote.twote = [dict objectForKey:@"twote"];
            twote.overallVotes = [NSNumber numberWithInt:[[dict objectForKey:@"overall_votes"] intValue]];
            [twotes addObject:twote];
        }
        block(YES, twotes);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        block(NO, NULL);
    }];
    [operation start];
}

- (void) twoteWithName:(NSString *)twoteName andCompletion:(void(^)(BOOL success, TWTwote *twote))block
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://twote.io/twote/%@", twoteName]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        TWTwote *twote = [[TWTwote alloc] init];
        NSDictionary *result = [JSON objectForKey:@"result"];
        twote.twote = [result objectForKey:@"twote"];
        twote.overallVotes = [NSNumber numberWithInt:[[result objectForKey:@"overall_votes"] intValue]];
        twote.votes = [result objectForKey:@"votes"];
        block(YES, twote);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        block(NO, NULL);
    }];
    [operation start];
}
@end
