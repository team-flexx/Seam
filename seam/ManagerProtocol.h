//
//  ManagerProtocol.h
//  
//
//  Created by festusojo on 7/17/19.
//

#import <Foundation/Foundation.h>

@protocol ManagerProtocol <NSObject>

@required
- (void)newJobsWithCompletion:(void(^)(NSArray *jobListings, NSError *error))completion;
- (void)ifSwipedRight:(NSArray*)alteredApplicantArray;
- (void)ifSwipedLeft:(NSArray*)shorterJobArray;
- (void)ifMatchOccurs:(NSArray*)applicantArray :(NSArray*)employerArray;

@end

@interface ManagerProtocol : NSObject

@end
