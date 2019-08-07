//
//  SMJobListing.m
//  seam
//
//  Created by laurenjle on 7/15/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMJobListing.h"

#import <Parse/PFObject+Subclass.h>

@implementation SMJobListing

@dynamic author;
@dynamic direction;
@dynamic typeOfJob;
@dynamic companyName;
@dynamic locationName;
@dynamic jobID;
@dynamic title;
@dynamic jobDescription;
@dynamic jobURL;

//can just use new/init alloc now instead of init

//registers to Parse
+ (void)load {
    [self registerSubclass];
}

+ (nonnull NSString *)parseClassName {
    return @"SMJobListing";
}

@end
