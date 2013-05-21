//
//  TWTwoteTests.m
//  Twote.io
//
//  Created by Marcus Kida on 21.05.13.
//  Copyright (c) 2013 Twote.io. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "TWTwote.h"

@interface TWTwoteTests : SenTestCase

@property (nonatomic, strong) TWTwote *sut;

@end

@implementation TWTwoteTests

#pragma mark - Fixtures
- (void) setUp
{
    [self setSut:[[TWTwote alloc] init]];
}

- (void) tearDown
{
    [self setSut:nil];
}

#pragma mark - Tests
- (void) testTwoteIsSuccessfullyInitialized
{
    STAssertNotNil([self sut], nil);
}

- (void) testTwoteCorrectlyStoreTwoteName
{
    // Given
    NSString *testtwote = @"testtwote";
    
    // When
    [[self sut] setTwote:testtwote];
    
    // Then
    STAssertTrue([[[self sut] twote] isEqualToString:testtwote], nil);
}

- (void) testTwoteCorrectlyStoresOverallVotes
{
    // Given
    int overallVotes = 9;
    
    // When
    [[self sut] setOverallVotes:@(overallVotes)];
    
    // Then
    STAssertTrue([[[self sut] overallVotes] intValue] == overallVotes, nil);
}

- (void) testTwoteCorrectlyStoresVotes
{
    // Given
    NSDictionary *votes = @{@"voting1":@9};
    
    // When
    [[self sut] setVotes:votes];
    
    // Then
    STAssertTrue(([[[[self sut] votes] objectForKey:[[votes allKeys] objectAtIndex:0]] intValue] == [[votes objectForKey:[[votes allKeys] objectAtIndex:0]] intValue]), nil);
}

@end
