//
//  Question.h
//  StackOverflowSDK
//
//  Created by Igor Nabokov on 20.01.16.
//  Copyright © 2016 Igor Nabokov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (strong, nonatomic) NSString *answer_count;
@property (strong, nonatomic) NSString *question_id;
@property (strong, nonatomic) NSString *title;


@end
