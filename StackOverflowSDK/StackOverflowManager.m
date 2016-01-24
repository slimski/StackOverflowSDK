//
//  StackOverflowManager.m
//  StackOverflowSDK
//
//  Created by Igor Nabokov on 22.01.16.
//  Copyright © 2016 Igor Nabokov. All rights reserved.
//

#import "StackOverflowManager.h"
#import "ModelsConverter.h"
#import "StackOverflowCommunicator.h"
#import "SearchQueryDelegate.h"

@implementation StackOverflowManager

- (void)searchQuestionsByText:(NSString *)text
{
    NSLog(@"Start searching questions by text: %@", text);
    [self.communicator searchQuestionsByText:text];
}

- (void)searchCompletedWithResult:(NSData *)result
{
    NSError *error = nil;
    NSArray *questions = [ModelsConverter questionsFromJsonData:result error:&error];
    
    if (error != nil)
    {
        [self searchFailedWithError:error];
    }
    else
    {
        [self.searchDelegate searchCompletedWithResult:questions];
    }
    
}

- (void)searchFailedWithError:(NSError *)error
{
    [self.searchDelegate searchFailedWithError:error];
}

@end
