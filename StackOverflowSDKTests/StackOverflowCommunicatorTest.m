//
//  StackOverflowCommunicatorTest.m
//  StackOverflowSDK
//
//  Created by Igor Nabokov on 21.01.16.
//  Copyright © 2016 Igor Nabokov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StackOverflowCommunicatorDelegate.h"
#import "StackOverflowCommunicator.h"

@interface StackOverflowCommunicatorTest : XCTestCase<StackOverflowCommunicatorDelegate>
@property (strong, nonatomic) StackOverflowCommunicator *communicator;
@property (strong, nonatomic) NSData *receivedResult;
@property (strong, nonatomic) NSError *receivedError;

@end

@implementation StackOverflowCommunicatorTest
BOOL done;

- (void)searchCompletedWithResult:(NSData *)result
{
    self.receivedResult = result;
    done = YES;
}

- (void)searchFailedWithError:(NSError *)error
{
    self.receivedError = error;
    done = YES;
}

- (void)popularUserQuestionsCompletedWithResult:(NSData *)result
{
    self.receivedResult = result;
    done = YES;
}

- (void)popularUserQuestionsFailedWithError:(NSError *)error
{
    self.receivedError = error;
    done = YES;
}

- (void)popularTagQuestionsCompletedWithResult:(NSData *)result
{
    self.receivedResult = result;
    done = YES;
}

- (void)popularTagQuestionsFailedWithError:(NSError *)error
{
    self.receivedError = error;
    done = YES;
}

- (void)setUp
{
    [super setUp];
    self.receivedResult = nil;
    self.receivedError = nil;
    done = NO;
    self.communicator = [[StackOverflowCommunicator alloc]init];
    self.communicator.delegate = self;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSearchQuestion
{
    XCTAssertFalse(self.receivedResult);
    XCTAssertFalse(self.receivedError);
    XCTAssertFalse(done);
    [self.communicator searchQuestionsByText:@"UINavigationController"];
    XCTAssertTrue([self waitForCompletion:10.0]);
    XCTAssertTrue(self.receivedResult);
    XCTAssertFalse(self.receivedError);
}

- (void)testPopularUserQuestions
{
    XCTAssertFalse(self.receivedResult);
    XCTAssertFalse(self.receivedError);
    XCTAssertFalse(done);
    [self.communicator getPopularQuestionsByOwnerId:1];
    XCTAssertTrue([self waitForCompletion:10.0]);
    XCTAssertTrue(self.receivedResult);
    XCTAssertFalse(self.receivedError);
}



- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSecs
{
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSecs];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
        if([timeoutDate timeIntervalSinceNow] < 0.0)
            break;
    } while (!done);
    
    return done;
}

@end
