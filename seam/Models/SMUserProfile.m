//
//  UserProfile.m
//  seam
//
//  Created by festusojo on 7/24/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMUserProfile.h"

#import "Parse/Parse.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation SMUserProfile

- (instancetype)initWithAbout:(NSString *)about
                    education:(NSString *)education
                        title:(NSString *)title
                      company:(NSString *)company
               jobDescription:(NSString *)jobDescription
                       skills:(NSString *)skills
                     jobStack:(NSMutableArray *)jobStack
              applicantSwipes:(NSMutableArray *)applicantSwipes
          applicantRejections:(NSMutableArray *)applicantRejections
                   matchArray:(NSMutableArray *)matchArray
{
    if (self = [super init]) {
        _about = about;
        _education = education;
        _title = title;
        _company = company;
        _jobDescription = jobDescription;
        _skills = skills;
        _jobStack= jobStack;
        _applicantSwipes = applicantSwipes;
        _applicantRejections = applicantRejections;
        _matchArray = matchArray;
    }
    
    return self;
}

@end
