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
#import "SearchDelegate.h"
#import "AnswersDelegate.h"
#import "QuestionsDelegate.h"

@implementation StackOverflowManager

-(id)init
{
    self = [super init];
    if (self)
    {
        self.communicator = [[StackOverflowCommunicator alloc] init];
        self.communicator.delegate = self;
        self.communicator.questionsDelegate = self;
        self.communicator.answersDelegate = self;
    }
    return self;
}

- (void)searchQuestionsByText:(NSString *)text
{
    NSLog(@"Start searching questions by text: %@", text);
    [self.communicator searchQuestionsByText:text];
}

- (void)getQuestionsByAuthor:(int)authorId
{
    NSLog(@"Start getting questions by author id: %i", authorId);
    [self.communicator getPopularQuestionsByOwnerId:authorId];
}

- (void)getQuestionsByTag:(NSString *)tag
{
    NSLog(@"Start getting questions by tag: %@", tag);
    [self.communicator getPopularQuestionsByTag:tag];
}

- (void)getAnswersByQuestion:(int)questionId
{
    NSLog(@"Start getting answers by question: %i", questionId);
    [self.communicator getAnswersForQuestionId:questionId];
 
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

- (void)popularTagQuestionsCompletedWithResult:(NSData *)result
{
    NSError *error = nil;
    NSArray *questions = [ModelsConverter questionsFromJsonData:result error:&error];
    
    if (error != nil)
    {
        [self popularTagQuestionsFailedWithError:error];
    }
    else
    {
        [self.questionsDelegate questionsReceivedWithResult:questions];
    }
}

- (void)popularTagQuestionsFailedWithError:(NSError *)error
{
    [self.questionsDelegate questionsFailedWithError:error];
}

- (void)popularUserQuestionsCompletedWithResult:(NSData *)result
{
    NSError *error = nil;
    NSArray *questions = [ModelsConverter questionsFromJsonData:result error:&error];
    
    if (error != nil)
    {
        [self popularUserQuestionsFailedWithError:error];
    }
    else
    {
        [self.questionsDelegate questionsReceivedWithResult:questions];
    }
    
}

- (void)popularUserQuestionsFailedWithError:(NSError *)error
{
    
}

- (void)questionAnswersCompletedWithResult:(NSData *)result
{
    NSError *error = nil;
    NSArray *answers = [ModelsConverter answersFromJsonData:result error:&error];
    
    if (error != nil)
    {
        [self questionAnswersFailedWithError:error];
    }
    else
    {
        [self.answersDelegate answersReceivedWithResult:answers];
    }

}

-(void)questionAnswersFailedWithError:(NSError *)error
{
    [self.answersDelegate answersFailedWithError:error];
}


@end
