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

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    StackOverflowManager *manager = [[StackOverflowManager alloc] init];
    XCTAssertTrue(manager);
    
}


@end
