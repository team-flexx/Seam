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

@property (nonatomic, strong) NSString *jobCompany;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *jobDescription;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *dates;
@property (nonatomic, strong) NSString *duties;
@property (nonatomic, strong) NSString *jobID;

- (instancetype)initWithJobCompany:(NSString *)jobCompany
                             title:(NSString *)title
                    jobDescription:(NSString *)jobDescription
                          location:(NSString *)location
                             dates:(NSString *)dates
                            duties:(NSString *)duties
                             jobID:(NSString *)jobID;

@end

NS_ASSUME_NONNULL_END
