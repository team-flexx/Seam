//
//  SMJobsDataManagerProvider.h
//  seam
//
//  Created by laurenjle on 7/29/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMJobsDataManaging.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMJobsDataManagerProvider : NSObject

+ (id<SMJobsDataManaging>)sharedDataManager;

@end

NS_ASSUME_NONNULL_END
