//
//  SMJobsDataManaging.h
//  
//
//  Created by festusojo on 7/17/19.
//

#import <Foundation/Foundation.h>

@protocol SMJobsDataManaging <NSObject>

@required

//fetch jobs on main matching screen upon loading
- (void)fetchJobsWithCompletion:(void(^)(NSArray *jobListings, NSError *error))completion;

//add jobs users swipe right on to their personal array
- (void)onApplyForJob:(NSArray*)alteredApplicantArray;

//add jobs users swipe left on to their personal array
- (void)onRejectJob:(NSArray*)alteredApplicantArray;

//removes job from general job array
- (void)onUninterestedInJob:(NSArray*)shorterJobArray;

//fetch jobs on main matching screen upon loading
- (void)fetchMatchesWithCompletion:(void (^)(NSArray *matches, NSError *error))completion;


@end
