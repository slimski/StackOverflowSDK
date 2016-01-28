//
//  ManagerTests.m
//  StackOverflowSDK
//
//  Created by Igor Nabokov on 22.01.16.
//  Copyright © 2016 Igor Nabokov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StackOverflowSDK.h"

@interface ManagerTests : XCTestCase

@end

@implementation ManagerTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample {
    StackOverflowManager *manager = [[StackOverflowManager alloc] init];
    XCTAssertTrue(manager);
    XCTAssertTrue(manager.communicator);
    XCTAssertTrue(manager.communicator.delegate == manager);
}


@end
