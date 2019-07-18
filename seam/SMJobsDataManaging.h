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

//removes job from general job array
- (void)onUninterestedInJob:(NSArray*)shorterJobArray;

//compare employer and employee arrays for identical items to form a match 
- (void)onMatch:(NSArray *)applicantArray :(NSArray *)employerArray :(NSArray *)matchArray;


@end
