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

//this fetches the data to load on the matches page
- (void)fetchJobsWithCompletion:(void (^)(NSArray *jobListings, NSError *error))completion {
    NSArray *jobListings = @[
                             [[SMJobListing alloc]
                              initWithJobCompany:@"Facebook"
                              title:@"Python Developer"
                              jobDescription:@"Work on projects tackling problems with Python"
                              location:@"Austin, TX, USA"
                              dates:@"August 2019"
                              duties:@"Excitement and eagerness to learn new technology. Passion for IT development and desire to gain in-depth knowledge"
                              jobID:@"1"],
                             [[SMJobListing alloc]
                              initWithJobCompany:@"Lyft"
                              title:@"AI Engineer"
                              jobDescription:@"Develop solutions utilizing machine learning"
                              location:@"San Francisco, CA, USA"
                              dates:@"August 2019"
                              duties:@"Excitement and eagerness to learn new technology. Understanding of machine learning principles."
                              jobID:@"2"],
                             [[SMJobListing alloc]
                              initWithJobCompany:@"Deloitte"
                              title:@"Technical Consultant"
                              jobDescription:@"Discuss business solutions in a technical space"
                              location:@"London, England, UK"
                              dates:@"August 2019"
                              duties:@"Deep understanding of technical problems and"
                              jobID:@"3"],
                             ];
    completion(jobListings, nil);
}

//add items swiped right on to the applicant's array and handles
//matching functionality using set of both arrays and then this will give you only the objects that are in both sets
- (void)onApplyForJob:(NSArray*)alteredApplicantArray {
    [self.applicantSwipes addObjectsFromArray:alteredApplicantArray];
    NSMutableSet* set1 = [NSMutableSet setWithArray:self.applicantSwipes];
    NSMutableSet* set2 = [NSMutableSet setWithArray:self.employerSwipes];
    [set1 intersectSet:set2];
    [self.matchArray addObject:set1];
    NSLog(@"%@",_matchArray); 
}

//loades matches on match view controller
- (void)fetchMatchesWithCompletion:(void (^)(NSArray *matches, NSError *error))completion {
    NSArray *matches= [NSArray new];
    completion(matches, nil);
}

//make this once so we can keep acessing the shared
+ (instancetype)shared {
    static SMFakeJobsDataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
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
