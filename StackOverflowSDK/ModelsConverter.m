//
//  ModelsConverter.m
//  StackOverflowSDK
//
//  Created by Igor Nabokov on 21.01.16.
//  Copyright © 2016 Igor Nabokov. All rights reserved.
//

#import "ModelsConverter.h"
#import "Question.h"

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
    
    for (NSDictionary *groupDic in results) {
        Question *question = [[Question alloc] init];
        
        for (NSString *key in groupDic) {
            if ([question respondsToSelector:NSSelectorFromString(key)]) {
                [question setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [questions addObject:question];
    }
    
    return questions;
}

@end
