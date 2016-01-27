//
//  StackOverflowCommunicator.m
//  StackOverflowSDK
//
//  Created by Igor Nabokov on 20.01.16.
//  Copyright © 2016 Igor Nabokov. All rights reserved.
//

#import "StackOverflowCommunicator.h"
#import "SearchQueryDelegate.h"
#import "PopularQuestionsDelegate.h"
#import "QuestionAnswersDelegate.h"

@implementation StackOverflowCommunicator
-(void)searchQuestionsByText:(NSString *)text
{
    NSString *rawUrl = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=%@&site=stackoverflow", text];
    NSLog(@"%@", rawUrl);

    NSURL *url = [[NSURL alloc] initWithString:rawUrl];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate searchFailedWithError:error];
        } else {
            [self.delegate searchCompletedWithResult:data];
        }
    }];
}

- (void)getPopularQuestionsByOwnerId:(int)ownerId
{
    NSString *rawUrl = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/users/%i/questions?order=desc&sort=votes&site=stackoverflow", ownerId];
    NSLog(@"%@", rawUrl);
    
    NSURL *url = [[NSURL alloc] initWithString:rawUrl];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.questionsDelegate popularUserQuestionsFailedWithError:error];
        } else {
            [self.questionsDelegate popularUserQuestionsCompletedWithResult:data];
        }
    }];
}

- (void)getPopularQuestionsByTag:(NSString *)tag
{
    NSString *rawUrl = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/questions?order=desc&sort=votes&tagged=%@&site=stackoverflow", tag];
    NSLog(@"%@", rawUrl);
    
    NSURL *url = [[NSURL alloc] initWithString:rawUrl];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.questionsDelegate popularTagQuestionsFailedWithError:error];
        } else {
            [self.questionsDelegate popularTagQuestionsCompletedWithResult:data];
        }
    }];
}

- (void)getAnswersForQuestionId:(int)questionId
{
    NSString *rawUrl = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/questions/%i/answers?order=desc&sort=activity&site=stackoverflow&filter=withbody", questionId];
    NSLog(@"%@", rawUrl);
    
    NSURL *url = [[NSURL alloc] initWithString:rawUrl];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.answersDelegate questionAnswersFailedWithError:error];
        } else {
            [self.answersDelegate questionAnswersCompletedWithResult:data];
        }
    }];
}


@end
