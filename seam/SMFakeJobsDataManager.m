//
//  SMFakeJobsDataManager.m
//  seam
//
//  Created by festusojo on 7/16/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMFakeJobsDataManager.h"
#import "SMJobListing.h"

@interface SMFakeJobsDataManager ()

@property (nonatomic, strong) NSMutableArray<SMJobListing *> *applicantSwipes;
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *employerSwipes;
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *matchArray;
@end


@implementation SMFakeJobsDataManager

- (void)fetchJobsWithCompletion:(void (^)(NSArray *jobListings, NSError *error))completion {
    NSArray *jobListings = @[
                             [[SMJobListing alloc]
                              initWithJobCompany:@"Facebook"
                              title:@"Facebook Python Developer"
                              jobDescription:@"Work on projects tackling problems with Python"
                              location:@"Austin, TX, USA"
                              dates:@"August 2019"
                              duties:@"Excitement and eagerness to learn new technology. Passion for IT development and desire to gain in-depth knowledge"
                              jobID:@"1"],
                             ];
    completion(jobListings, nil);
}

//add items swiped right on to the applicant's array
- (void)onApplyForJob:(NSArray*)alteredApplicantArray {
    [self.applicantSwipes addObjectsFromArray:alteredApplicantArray];
    //matching functionality - creates set of both arrays and then this will give you only the objects that are in both sets
    NSMutableSet* set1 = [NSMutableSet setWithArray:self.applicantSwipes];
    NSMutableSet* set2 = [NSMutableSet setWithArray:self.employerSwipes];
    [set1 intersectSet:set2];
    [self.matchArray addObject:set1];
}

//loades matches on match view controller
- (void)fetchMatchesWithCompletion:(void (^)(NSArray *matches, NSError *error))completion {
    NSArray *matches= [NSArray new];
    completion(matches, nil);
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
