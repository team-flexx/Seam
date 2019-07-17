//
//  ManagerProtocol.h
//  seam
//
//  Created by festusojo on 7/17/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ManagerProtocol

- (void)newJobsWithCompletion:(void(^)(NSArray *jobListings, NSError *error))completion;
- (void)onSwipeRight:(NSArray *);
- (void)ifSwipedRight:(NSArray *);
- (void)ifSwipedLeft:(NSArray *);
- (void)ifMatchOccurs:(NSArray*)applicantArray :(NSArray*)employerArray;

@end

@interface Manager Protocol : NSObject

@end
