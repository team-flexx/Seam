//
//  SMJobListing.h
//  seam
//
//  Created by laurenjle on 7/15/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "Parse/Parse.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMApplicantSwipeRight : PFObject <PFSubclassing>

//properties used in SMJobCard
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *direction;
@property (nonatomic, strong) NSString *typeOfJob;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, strong) NSString *jobID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *jobDescription;

@end

NS_ASSUME_NONNULL_END
