//
//  UserProfile.h
//  seam
//
//  Created by festusojo on 7/24/19.
//  Copyright © 2019 codepath. All rights reserved.

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMUserProfile: NSObject

@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *jobDescription;
@property (nonatomic, strong) NSString *skills;
@property (nonatomic, strong) NSMutableArray *jobStack;
@property (nonatomic, strong) NSMutableArray *applicantSwipes;
@property (nonatomic, strong) NSMutableArray *applicantRejections;
@property (nonatomic, strong) NSMutableArray *matchArray;

//init 
- (instancetype)initWithAbout:(NSString *)about
                    education:(NSString *)education
                        title:(NSString *)title
                      company:(NSString *)company
               jobDescription:(NSString *)jobDescription
                       skills:(NSString *)skills
                     jobStack:(NSMutableArray *)jobStack
              applicantSwipes:(NSMutableArray *)applicantSwipes
          applicantRejections:(NSMutableArray *)applicantRejections
                   matchArray:(NSMutableArray *)matchArray;

@end

NS_ASSUME_NONNULL_END
