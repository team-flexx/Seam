//
//  SMJobListing.m
//  seam
//
//  Created by laurenjle on 7/15/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMApplicantSwipeLeft.h"

#import <Parse/PFObject+Subclass.h>

@implementation SMApplicantSwipeLeft

@dynamic author;
@dynamic jobID;

//can just use new/init alloc now instead of init

//registers to Parse
+ (void)load {
    [self registerSubclass];
}

+ (nonnull NSString *)parseClassName {
    return @"SMApplicantSwipeLeft";
}

@end
