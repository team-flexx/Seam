//
//  UserProfile.m
//  seam
//
//  Created by festusojo on 7/24/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile

@dynamic userName;
@dynamic personalAbout;
@dynamic education;
@dynamic title;
@dynamic company;
@dynamic jobDescription;
@dynamic skills;


+ (nonnull NSString *)parseClassName {
    return @"UserProfile";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    //this allows for a new post and sets the values for each of the required properties Parse is looking for
    UserProfile *newUserProfile = [UserProfile new];
    newUserProfile.userName = [PFUser currentUser];
    newUserProfile =
    
    
    
    newPost.caption = caption;
}

//method here
//@implementation XYZPerson (XYZPersonNameDisplayAdditions)
//- (NSString *)lastNameFirstNameString {
//    return [NSString stringWithFormat:@"%@, %@", self.lastName, self.firstName];
//}

@end
