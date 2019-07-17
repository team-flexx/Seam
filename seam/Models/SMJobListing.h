//
//  SMJobListing.h
//  seam
//
//  Created by laurenjle on 7/15/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMJobListing : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *dates;
@property (nonatomic, strong) NSString *job_id;

//check available data to create properties
//job name
//job description
//time slot for job


@end

NS_ASSUME_NONNULL_END
