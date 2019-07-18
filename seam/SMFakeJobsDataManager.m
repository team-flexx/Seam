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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)fetchJobsWithCompletion:(void (^)(NSArray *, NSError *))completion {
}

- (void)onApplyForJob:(NSArray *)alteredApplicantArray {
}

- (void)onMatch:(NSArray *)applicantArray :(NSArray *)employerArray {
}

- (void)onUninterestedInJob:(NSArray *)shorterJobArray {
}

@end
