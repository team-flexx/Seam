//
//  SMJobs.m
//  seam
//
//  Created by festusojo on 7/30/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMJobs.h"

#import <Parse/PFObject+Subclass.h>

@implementation SMJobs

@dynamic jobListing;

+ (void)load {
    [self registerSubclass];
}

+ (nonnull NSString *)parseClassName {
    return @"SMJobs";
}

@end
