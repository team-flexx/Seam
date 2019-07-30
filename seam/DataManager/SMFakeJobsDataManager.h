//
//  SMJobsDataAPIManager.h
//  seam
//
//  Created by festusojo on 7/16/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMJobsDataManaging.h"
#import "SMUserProfile.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMFakeJobsDataManager: NSObject <SMJobsDataManaging>

@property SMUserProfile *userProfile;

@end

NS_ASSUME_NONNULL_END
