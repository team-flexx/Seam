//
//  SMJobsDataAPIManager.h
//  seam
//
//  Created by festusojo on 7/16/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMJobsDataManaging.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMFakeJobsDataManager: NSObject <SMJobsDataManaging>

//as of sprint 1, we hard-coded fake data

//this returns a dictionary of a job listing that we can use in the view controller (SwipingScreenViewController.m) to send this data to display on UI
//Note: the Model file SMJobListing.h contains a method that initializes a jobListing which is called in this .m file.
- (void)fetchJobsWithCompletion:(void (^)(NSArray *jobListings, NSError *error))completion;

- (void)onApplyForJob:(NSArray*)alteredApplicantArray;


- (void)fetchMatchesWithCompletion:(void (^)(NSArray *matches, NSError *error))completion;


//use this to access data in SwipingScreenViewController
+ (instancetype)shared;
@end

NS_ASSUME_NONNULL_END
