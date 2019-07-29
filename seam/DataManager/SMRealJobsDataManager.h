//  SMRealJobsDataManager.h
//  seam
//
//  Created by laurenjle on 7/25/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMJobsDataManaging.h"
NS_ASSUME_NONNULL_BEGIN

@interface SMRealJobsDataManager : NSObject <SMJobsDataManaging>

- (void)fetchJobs;

@end

NS_ASSUME_NONNULL_END
