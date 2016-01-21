//
//  StackOverflowCommunicator.m
//  StackOverflowSDK
//
//  Created by Igor Nabokov on 20.01.16.
//  Copyright © 2016 Igor Nabokov. All rights reserved.
//

#import "StackOverflowCommunicator.h"
#import "StackOverflowCommunicatorDelegate.h"

@implementation StackOverflowCommunicator
-(void)searchQuestionsByText:(NSString *)text
{
    NSString *rawUrl = [NSString stringWithFormat:@"http://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=%@&site=stackoverflow", text];
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

- (void)getPopularQuestionsByOwnerId:(NSUInteger)ownerId
{
    NSString *rawUrl = [NSString stringWithFormat:@"http://api.stackexchange.com/2.2/users/%lu/questions?order=desc&sort=votes&site=stackoverflow", (unsigned long)ownerId];
    NSLog(@"%@", rawUrl);
    
    NSURL *url = [[NSURL alloc] initWithString:rawUrl];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate popularUserQuestionsFailedWithError:error];
        } else {
            [self.delegate popularUserQuestionsCompletedWithResult:data];
        }
    }];
}

- (void)getPopularQuestionsByTag:(NSString *)tag
{
    NSString *rawUrl = [NSString stringWithFormat:@"http://api.stackexchange.com/2.2/questions?order=desc&sort=votes&tagged=%@&site=stackoverflow", tag];
    NSLog(@"%@", rawUrl);
    
    NSURL *url = [[NSURL alloc] initWithString:rawUrl];
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate popularTagQuestionsFailedWithError:error];
        } else {
            [self.delegate popularTagQuestionsCompletedWithResult:data];
        }
    }];
}


@end
