//
//  StackOverflowCommunicator.h
//  StackOverflowSDK
//
//  Created by Igor Nabokov on 20.01.16.
//  Copyright © 2016 Igor Nabokov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StackOverflowCommunicatorDelegate;

@interface StackOverflowCommunicator : NSObject

@property (weak, nonatomic) id<StackOverflowCommunicatorDelegate> delegate;
- (void)searchQuestionsByText:(NSString *)text;
- (void)getPopularQuestionsByOwnerId:(NSUInteger)ownerId;
- (void)getPopularQuestionsByTag:(NSString *)tag;

@end
