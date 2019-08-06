//
//  PFUser+SMUserProfile.m
//  seam
//
//  Created by festusojo on 7/24/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "PFUser+SMUserProfile.h"

#import "SMUserProfile.h"

static NSString *const aboutConstant = @"about";
static NSString *const educationConstant = @"education";
static NSString *const titleConstant = @"title";
static NSString *const companyConstant = @"company";
static NSString *const jobDescriptionConstant = @"jobDescription";
static NSString *const skillsConstant = @"skills";
static NSString *const jobStackConstant = @"jobStack";
static NSString *const applicantSwipesConstant = @"applicantSwipes";
static NSString *const applicantRejectionsConstant = @"applicantRejections";
static NSString *const matchArrayConstant = @"matchArray";

//makes category of basic NSObject with added functionality
@implementation PFUser (SMUserProfile)


//reading side, look for nil
- (NSString *)checkForNullString:(id)inputVal {
    if (inputVal) {
        return inputVal;
    }
    else {
        return @"";
    }
}

- (NSMutableArray *)checkForNullArray:(NSMutableArray *)inputVal {
    if (inputVal) {
        return inputVal;
    }
    else {
        NSMutableArray *sampleInput = [NSMutableArray new];
        return sampleInput;
    }
}

//getter
- (SMUserProfile*)userProfile {
    
    //alloc to initialize with keys
    return
    [[SMUserProfile alloc]
     initWithAbout:[self checkForNullString:[self objectForKey:aboutConstant]]
     education:[self checkForNullString:[self objectForKey:educationConstant]]
     title:[self checkForNullString:[self objectForKey:titleConstant]]
     company:[self checkForNullString:[self objectForKey:companyConstant]]
     jobDescription:[self checkForNullString:[self objectForKey:jobDescriptionConstant]]
     skills:[self checkForNullString:[self objectForKey:skillsConstant]]
     jobStack:[self checkForNullArray:[self objectForKey:jobStackConstant]]
     applicantSwipes:[self checkForNullArray:[self objectForKey:applicantSwipesConstant]]
     applicantRejections:[self checkForNullArray:[self objectForKey:applicantRejectionsConstant]]
     matchArray:[self checkForNullArray:[self objectForKey:matchArrayConstant]]];
}

-(void)checkForNil:(id)inputVal :(NSString*)resultingVal {
    if (inputVal) {
        [self setObject:inputVal forKey:resultingVal];
    }
    else {
        [self setObject:[NSNull null] forKey:resultingVal];
    }
}

//setter
- (void)setUserProfile:(SMUserProfile *)userProfile {
    [self checkForNil:userProfile.about :aboutConstant];
    [self checkForNil:userProfile.education :educationConstant];
    [self checkForNil:userProfile.title :titleConstant];
    [self checkForNil:userProfile.company :companyConstant];
    [self checkForNil:userProfile.jobDescription :jobDescriptionConstant];
    [self checkForNil:userProfile.skills:skillsConstant];
    [self checkForNil:userProfile.jobStack :jobStackConstant];
    [self checkForNil:userProfile.applicantSwipes :applicantSwipesConstant];
    [self checkForNil:userProfile.applicantRejections :applicantRejectionsConstant];
    [self checkForNil:userProfile.matchArray :matchArrayConstant];
}
     
@end
