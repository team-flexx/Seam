//
//  SMFakeJobsDataManager.m
//  seam
//
//  Created by festusojo on 7/16/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMFakeJobsDataManager.h"

@interface SMFakeJobsDataManager ()

@end

@implementation SMFakeJobsDataManager

- (void)fetchJobsWithCompletion:(void (^)(NSArray *, NSError *))completion {
    // Success, initalizes both arrays for employer and user
    NSMutableArray *applicant_swipes = [[NSMutableArray alloc] init];
    NSMutableArray *employer_swipes = [[NSMutableArray alloc] init];
    completion(jobListings, nil);
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    // There was a problem, this goes in to the error output
    completion(nil, error);
}

//add items swiped right on to the applicant's array
- (void)onApplyForJob:(NSArray *)alteredApplicantArray {
    [alteredApplicantArray addObject:jobListing];
}

//creates set of both arrays and then this will give you only the objects that are in both sets
- (void)onMatch:(NSArray *)applicantArray :(NSArray *)employerArray :(NSArray *)matchArray{
    NSMutableSet* set1 = [NSMutableSet setWithArray:applicantArray];
    NSMutableSet* set2 = [NSMutableSet setWithArray:employerArray];
    Intersection = [set1 intersectSet:set2];
    [matchArray addObject:intersection];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
