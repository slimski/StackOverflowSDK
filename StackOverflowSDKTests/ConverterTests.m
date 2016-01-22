//
//  ConverterTests.m
//  StackOverflowSDK
//
//  Created by Igor Nabokov on 21.01.16.
//  Copyright © 2016 Igor Nabokov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"
#import "Question.h"
#import "ModelsConverter.h"

@interface ConverterTests : XCTestCase

@end

@implementation ConverterTests
NSData *testData;
- (void)setUp {
    [super setUp];
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"testData" ofType:@"json"];
    NSString *data = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    testData = [data dataUsingEncoding:NSUTF8StringEncoding];
    XCTAssertTrue(testData);

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSError *error = nil;
    NSArray *result = [ModelsConverter questionsFromJsonData:testData error:&error];
    XCTAssertFalse(error);
    XCTAssertTrue(result);
    XCTAssertTrue(result.count == 30);
    for (Question *question in result) {
        XCTAssertTrue(question.title);
        XCTAssertTrue(question.question_id);
        XCTAssertTrue(question.owner);
        XCTAssertTrue(question.owner.user_id);
        XCTAssertTrue(question.owner.display_name);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
