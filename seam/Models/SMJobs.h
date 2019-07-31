//
//  SMJobs.h
//  seam
//
//  Created by festusojo on 7/30/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "Parse/Parse.h"
#import "SMJobListing.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMJobs : PFObject <PFSubclassing>

@property (nonatomic, strong) SMJobListing *jobListing;

@end

NS_ASSUME_NONNULL_END
