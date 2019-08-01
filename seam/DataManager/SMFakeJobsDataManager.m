//
//  SMFakeJobsDataManager.m
//  seam
//
//  Created by festusojo on 7/16/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMFakeJobsDataManager.h"

#import "Parse/Parse.h"
#import "PFUser+SMUserProfile.h"
#import "SMJobListing.h"
#import "SMUserProfile.h"

@interface SMFakeJobsDataManager ()

@property (nonatomic, strong) NSMutableArray<SMJobListing *> *applicantSwipes;
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *applicantRejections;
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *employerSwipes;
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *matchArray;
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *jobStack;
@end

@implementation SMFakeJobsDataManager

- (instancetype)init
{
    if (self = [super init]) {
        self.userProfile = PFUser.currentUser.userProfile;
        //loads user's swipes and arrays from Parse
        _applicantSwipes = [NSMutableArray new];
        _applicantSwipes = self.userProfile.applicantSwipes;
        _applicantRejections = [NSMutableArray new];
        _applicantRejections = self.userProfile.applicantRejections;
        _employerSwipes = [NSMutableArray new];
        _matchArray = [NSMutableArray new];
        _jobStack = [NSMutableArray new];
        _jobStack = self.userProfile.jobStack;
    }
    return self;
}

//this fetches the data to load on the matches page
//this returns a dictionary of a job listing that we can use in the view controller (SwipingScreenViewController.m) to send this data to display on UI
//Note: the Model file SMJobListing.h contains a method that initializes a jobListing which is called in this .m file.
- (void)fetchJobsWithCompletion:(void (^)(NSArray *jobListings, NSError *error))completion {
    
    SMJobListing *fakeJob =
    [[SMJobListing alloc] init];
    fakeJob.companyName = @"Facebook";
    fakeJob.jobDescription = @"Excitement and eagerness to learn new technology. Passion for IT development and desire to gain in-depth knowledge";
    fakeJob.jobID = @"1";
    fakeJob.locationName = @"Austin, TX, USA";
    fakeJob.title = @"Python Developer";
    
    //instantiates profile and passes array into it
    SMUserProfile *updatedProfile = PFUser.currentUser.userProfile;
    NSArray *jobListings = @[fakeJob];
    [self.jobStack addObject:jobListings];
    
    //passes jobStack into version on user's Parse account
    [updatedProfile.jobStack addObject:jobListings];
    completion(jobListings, nil);
    [PFUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
    }];
}

//add items swiped right on to the applicant's array and handles
//matching functionality using set of both arrays and then this will give you only the objects that are in both sets
- (void)onApplyForJob:(NSArray*)alteredApplicantArray {
    
    //instantiates profile and passes array into it
    SMUserProfile *updatedProfile = PFUser.currentUser.userProfile;
    [self.applicantSwipes addObjectsFromArray:alteredApplicantArray];
    updatedProfile.applicantSwipes = self.applicantSwipes;
    NSLog(@"applicant swipes: %@",_applicantSwipes);
    NSMutableSet* set1 = [NSMutableSet setWithArray:self.applicantSwipes];
    NSMutableSet* set2 = [NSMutableSet setWithArray:self.employerSwipes];
    [self.jobStack removeObject:set1];
    [updatedProfile.jobStack removeObject:set1];
    [set1 intersectSet:set2];
    [self.matchArray addObject:set1];
    NSLog(@"%@",_matchArray);
    
    //passes jobStack, matchArray, and applicantSwipes into version on user's Parse account
    updatedProfile.applicantSwipes = self.matchArray;
    [PFUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
    }];
}

- (void)onRejectJob:(NSArray*)alteredApplicantArray {
    
    //instantiates profile and passes array into it
    SMUserProfile *updatedProfile = PFUser.currentUser.userProfile;
    [self.applicantRejections addObjectsFromArray:alteredApplicantArray];
    updatedProfile.applicantRejections = self.applicantRejections;
    NSLog(@"applicant rejections: %@",_applicantRejections);
    NSMutableSet* set1 = [NSMutableSet setWithArray:self.applicantRejections];
    [self.jobStack removeObject:set1];
    [updatedProfile.jobStack removeObject:set1];
    NSLog(@"reject jobs: %@",_applicantRejections);
    
    //passes jobStack, matchArray, and applicantRejections into version on user's Parse account
    NSLog(@"reject jobs: %@", updatedProfile.applicantRejections);
    [PFUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
    }];
}

//loades matches on match view controller
- (void)fetchMatchesWithCompletion:(void (^)(NSArray *matches, NSError *error))completion {
    //instantiates profile and passes array into it
    SMUserProfile *updatedProfile = PFUser.currentUser.userProfile;
    
    NSArray *matches= [NSArray new];
    matches = self.matchArray;
    completion(matches, nil);
    
    //passes matchArray into version on user's Parse account
    [PFUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
    }];
}

@end

