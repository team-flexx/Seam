//
//  SMJobListing.m
//  seam
//
//  Created by laurenjle on 7/15/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMJobListing.h"

@implementation SMJobListing

- (instancetype)initWithJobCompany:(NSString *)jobCompany
                             title:(NSString *)title
                    jobDescription:(NSString *)jobDescription
                          location:(NSString *)location
                             dates:(NSString *)dates
                            duties:(NSString *)duties
                             jobID:(NSString *)jobID
{
    if ((self = [super init])) {
        _title = title;
        _jobCompany = jobCompany;
        _jobDescription = jobDescription;
        _location = location;
        _dates = dates;
        _duties = duties;
        _jobID = jobID;
    }
    return self;
}

@end
