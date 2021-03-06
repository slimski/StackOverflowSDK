//
//  StackOverflowCommunicatorTest.m
//  StackOverflowSDK
//
//  Created by Igor Nabokov on 21.01.16.
//  Copyright © 2016 Igor Nabokov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SearchQueryDelegate.h"
#import "PopularQuestionsDelegate.h"
#import "StackOverflowCommunicator.h"
#import "QuestionAnswersDelegate.h"

@interface StackOverflowCommunicatorTest : XCTestCase<SearchQueryDelegate, PopularQuestionsDelegate, QuestionAnswersDelegate>
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
    NSLog(@"Search failed with error:%@", error);
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

- (void)questionAnswersCompletedWithResult:(NSData *)result
{
    self.receivedResult = result;
    done = YES;
}

- (void)questionAnswersFailedWithError:(NSError *)error
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
    self.communicator.questionsDelegate = self;
    self.communicator.answersDelegate = self;
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
    [self.communicator searchQuestionsByText:@"Navigation Controller"];
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

- (void)testPopularTagQuestions
{
    XCTAssertFalse(self.receivedResult);
    XCTAssertFalse(self.receivedError);
    XCTAssertFalse(done);
    [self.communicator getPopularQuestionsByTag:@"ios"];
    XCTAssertTrue([self waitForCompletion:10.0]);
    XCTAssertTrue(self.receivedResult);
    XCTAssertFalse(self.receivedError);
}

- (void)testAnswers
{
    XCTAssertFalse(self.receivedResult);
    XCTAssertFalse(self.receivedError);
    XCTAssertFalse(done);
    [self.communicator getAnswersForQuestionId:34334462];
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
