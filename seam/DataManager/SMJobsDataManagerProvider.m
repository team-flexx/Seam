//
//  SMJobsDataManagerProvider.m
//  seam
//
//  Created by laurenjle on 7/29/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMJobsDataManagerProvider.h"

#import "SMFakeJobsDataManager.h"
#import "SMRealJobsDataManager.h"

@implementation SMJobsDataManagerProvider

+ (id<SMJobsDataManaging>)sharedDataManager
{
    static id<SMJobsDataManaging> sharedManager = nil;
    static dispatch_once_t onceToken;
    BOOL isDemoMode = YES;
    dispatch_once(&onceToken, ^{
        if (isDemoMode) {
            sharedManager = [[SMFakeJobsDataManager alloc] init];
        } else {
            sharedManager = [[SMRealJobsDataManager alloc] init];
        }
    });
    return sharedManager;
}

@end
