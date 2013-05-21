//
//  TWDataControllerTests.m
//  Twote.io
//
//  Created by Marcus Kida on 21.05.13.
//  Copyright (c) 2013 Twote.io. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "TWDataController.h"
#import "AFNetworking.h"

@interface TWDataControllerTests : SenTestCase

@property (nonatomic, strong) TWDataController *sut;

@end

@implementation TWDataControllerTests

#pragma mark - Fixtures
- (void) setUp
{
    [self setSut:[[TWDataController alloc] init]];
}

- (void) tearDown
{
    [self setSut:nil];
}

#pragma mark - Tests
- (void) testDataControllerIsSuccessfullyInitialized
{
    STAssertNotNil([self sut], nil);
}

@end
