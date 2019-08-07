//
//  Match.m
//  seam
//
//  Created by alexamorales on 8/6/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "Match.h"

@implementation Match

@dynamic companyName;

+ (nonnull NSString *)parseClassName {
    return @"SMMatches";
}

+ (void) postCompanyName: ( NSString * _Nullable )companyName withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Match *newMatch = [Match new];
    newMatch.companyName = companyName;
  //query the array, set value from parse =
    
}

@end
