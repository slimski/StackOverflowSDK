//
//  ModelsConverter.m
//  StackOverflowSDK
//
//  Created by Igor Nabokov on 21.01.16.
//  Copyright © 2016 Igor Nabokov. All rights reserved.
//

#import "ModelsConverter.h"
#import "Question.h"
#import "User.h"

@implementation ModelsConverter

+ (NSArray *)questionsFromJsonData:(NSData *)json error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:json options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"items"];
    NSLog(@"Count %lu", (unsigned long)questions.count);
    
    for (NSDictionary *result in results) {
        Question *question = [[Question alloc] init];
        
        for (NSString *key in result)
        {
            if ([key  isEqual: @"owner"])
            {
                [question setValue:[ModelsConverter userFromDictionary:[result valueForKey:key]] forKey:key];
            }
            else if ([question respondsToSelector:NSSelectorFromString(key)])
            {
                [question setValue:[result valueForKey:key] forKey:key];
            }
        }
        
        [questions addObject:question];
    }
    
    return questions;
}

+ (User *)userFromDictionary:(NSDictionary *)dict
{
    User *user = [[User alloc] init];
    for (NSString *key in dict)
    {
        if ([user respondsToSelector:NSSelectorFromString(key)])
        {
            [user setValue:[dict valueForKey:key] forKey:key];
        }
    }
    
    return user;
}

@end
