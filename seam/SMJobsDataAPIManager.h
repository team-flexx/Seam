//
//  SMJobsDataAPIManager.h
//  seam
//
//  Created by festusojo on 7/16/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//where does this go?
//@protocol SMJobsDataAPIManager
//
//- (NSArray)newJobs:();
//- (void)onSwipeRight:(NSArray *);
//- (void)ifSwipedRight:(NSArray *);
//- (void)ifSwipedLeft:(NSArray *);

@interface SMTestJobsDataAPIManager : NSObject <SMJobsDataAPIManager>

//is this where we would be initializing the dummy data?
//return [[[SMJobListing alloc]
//         initWithTitle: "Test Listing"
//         initWithDesc: "Test desc"]] ;

@end

NS_ASSUME_NONNULL_END
