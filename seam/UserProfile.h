//
//  UserProfile.h
//  seam
//
//  Created by festusojo on 7/24/19.
//  Copyright © 2019 codepath. All rights reserved.
//
#import <Parse/Parse.h>
#import "PFUser.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserProfile : NSObject (PFUser)

@property (nonatomic, strong) PFUser *userName;
@property (nonatomic, strong) NSString *personalAbout;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *jobDescription;
@property (nonatomic, strong) NSString *skills;

@end

NS_ASSUME_NONNULL_END
