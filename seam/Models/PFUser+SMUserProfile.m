//
//  PFUser+SMUserProfile.m
//  seam
//
//  Created by festusojo on 7/24/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "PFUser+SMUserProfile.h"

#import "SMUserProfile.h"

static NSString *const aConstant = @"about";
static NSString *const bConstant = @"education";
static NSString *const cConstant = @"title";
static NSString *const dConstant = @"company";
static NSString *const eConstant = @"jobDescription";
static NSString *const fConstant = @"skills";
static NSString *const gConstant = @"jobStack";
static NSString *const hConstant = @"applicantSwipes";
static NSString *const iConstant = @"applicantRejections";
static NSString *const jConstant = @"matchArray";

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

- (NSMutableArray *)checkForNullArray:(id)inputVal {
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
     initWithAbout:[self checkForNullString:aConstant]
     education:[self checkForNullString:bConstant]
     title:[self checkForNullString:cConstant]
     company:[self checkForNullString:dConstant]
     jobDescription:[self checkForNullString:eConstant]
     skills:[self checkForNullString:fConstant]
     jobStack:[self checkForNullArray:gConstant]
     applicantSwipes:[self checkForNullArray:hConstant]
     applicantRejections:[self checkForNullArray:iConstant]
     matchArray:[self checkForNullArray:jConstant]];
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
    [self checkForNil:userProfile.about :aConstant];
    [self checkForNil:userProfile.education :bConstant];
    [self checkForNil:userProfile.title :cConstant];
    [self checkForNil:userProfile.company :dConstant];
    [self checkForNil:userProfile.jobDescription :eConstant];
    [self checkForNil:userProfile.skills:fConstant];
    [self checkForNil:userProfile.jobStack :gConstant];
    [self checkForNil:userProfile.applicantSwipes :hConstant];
    [self checkForNil:userProfile.applicantRejections :iConstant];
    [self checkForNil:userProfile.matchArray :jConstant];
}
     
@end
