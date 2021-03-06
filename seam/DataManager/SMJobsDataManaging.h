//
//  SMJobsDataManaging.h
//
//
//  Created by festusojo on 7/17/19.
//

#import "SMJobListing.h"
#import "SMApplicantSwipeLeft.h"
#import "SMApplicantSwipeRight.h"


#import <Foundation/Foundation.h>

@protocol SMJobsDataManaging <NSObject>

@required

//fetch jobs on main matching screen upon loading
- (void)fetchJobsWithCompletion:(void(^)(NSArray *jobListings, NSError *error))completion;

//add jobs users swipe right on to their personal array
- (void)onApplyForJob:(SMJobListing*)chosenJob;

//add jobs users swipe left on to their personal array
- (void)onRejectJob:(SMJobListing*)chosenJob;

//fetch jobs on main matching screen upon loading
- (void)fetchMatchesWithCompletion:(void (^)(NSArray *matches, NSError *error))completion;

@end
