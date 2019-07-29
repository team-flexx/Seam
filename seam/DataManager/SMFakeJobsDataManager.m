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
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *applicantRejections;
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *employerSwipes;
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *matchArray;
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *jobStack;
@end


@implementation SMFakeJobsDataManager

- (instancetype)init
{
    if (self = [super init]) {
        _applicantSwipes = [NSMutableArray new];
        _applicantRejections = [NSMutableArray new];
        _employerSwipes = [NSMutableArray new];
        _matchArray = [NSMutableArray new];
        _jobStack = [NSMutableArray new];
    }
    return self;
}


//this fetches the data to load on the matches page
//this returns a dictionary of a job listing that we can use in the view controller (SwipingScreenViewController.m) to send this data to display on UI
//Note: the Mrodel file SMJobListing.h contains a method that initializes a jobListing which is called in this .m file.
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
    [self.jobStack addObject:jobListings];
    completion(jobListings, nil);
}

//add items swiped right on to the applicant's array and handles
//matching functionality using set of both arrays and then this will give you only the objects that are in both sets
- (void)onApplyForJob:(NSArray*)alteredApplicantArray {
    [self.applicantSwipes addObjectsFromArray:alteredApplicantArray];
    NSLog(@"applicant swipes: %@",_applicantSwipes);
    NSMutableSet* set1 = [NSMutableSet setWithArray:self.applicantSwipes];
    NSMutableSet* set2 = [NSMutableSet setWithArray:self.employerSwipes];
    [set1 intersectSet:set2];
    [self.matchArray addObject:set1];
    NSLog(@"%@",_matchArray);
}

- (void)onRejectJob:(NSArray*)alteredApplicantArray {
    [self.applicantRejections addObjectsFromArray:alteredApplicantArray];
    NSLog(@"applicant rejections: %@",_applicantRejections);
    NSMutableSet* set1 = [NSMutableSet setWithArray:self.applicantRejections];
    [self.jobStack removeObject:set1];
    NSLog(@"reject jobs: %@",_applicantRejections);
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
