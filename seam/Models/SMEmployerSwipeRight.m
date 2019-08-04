//
//  SMJobListing.m
//  seam
//
//  Created by laurenjle on 7/15/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMEmployerSwipeRight.h"

#import <Parse/PFObject+Subclass.h>

@implementation SMEmployerSwipeRight

@dynamic author;
@dynamic direction;
@dynamic typeOfJob;
@dynamic companyName;
@dynamic locationName;
@dynamic jobID;
@dynamic title;
@dynamic jobDescription;

//can just use new/init alloc now instead of init

//registers to Parse
+ (void)load {
    [self registerSubclass];
}

+ (nonnull NSString *)parseClassName {
    return @"SMEmployerSwipeRight";
}

@end

