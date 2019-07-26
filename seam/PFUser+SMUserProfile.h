//
//  PFUser+SMUserProfile.h
//  seam
//
//  Created by festusojo on 7/24/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMUserProfile.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFUser (SMUserProfile)

@property SMUserProfile *userProfile;

@end

NS_ASSUME_NONNULL_END
