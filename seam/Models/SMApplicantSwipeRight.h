//
//  SMJobListing.h
//  seam
//
//  Created by laurenjle on 7/15/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "Parse/Parse.h"

#import "SMJobListing.h"

#import <Foundation/Foundation.h>

@interface SMApplicantSwipeRight : PFObject <PFSubclassing>

//properties used in SMJobCard
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) SMJobListing *jobPointer;

@end
