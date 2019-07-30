//
//  PFUser+SMUserProfile.m
//  seam
//
//  Created by festusojo on 7/24/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "PFUser+SMUserProfile.h"

#import "SMUserProfile.h"

@implementation PFUser (SMUserProfile)

//getter
- (SMUserProfile*)userProfile {
    //alloc
    return
    [[SMUserProfile alloc]
     initWithAbout:[self objectForKey:@"about"]
     education:[self objectForKey:@"education"]
     title:[self objectForKey:@"title"]
     company:[self objectForKey:@"company"]
     jobDescription:[self objectForKey:@"jobDescription"]
     skills:[self objectForKey:@"skills"]
     jobStack:[self objectForKey:@"jobStack"]
     applicantSwipes:[self objectForKey:@"applicantSwipes"]
     applicantRejections:[self objectForKey:@"applicantRejections"]
     matchArray:[self objectForKey:@"matchArray"]];
}

//setter
- (void)setUserProfile:(SMUserProfile *)userProfile {
    [self setObject:userProfile.about forKey:@"about"];
    [self setObject:userProfile.education forKey:@"education"];
    [self setObject:userProfile.title forKey:@"title"];
    [self setObject:userProfile.company forKey:@"company"];
    [self setObject:userProfile.jobDescription forKey:@"jobDescription"];
    [self setObject:userProfile.skills forKey:@"skills"];
    [self setObject:userProfile.jobStack forKey:@"jobStack"];
    [self setObject:userProfile.applicantSwipes forKey:@"applicantSwipes"];
    [self setObject:userProfile.applicantRejections forKey:@"applicantRejections"];
    [self setObject:userProfile.matchArray forKey:@"matchArray"];
}
     
@end
