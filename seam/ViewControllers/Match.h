//
//  Match.h
//  seam
//
//  Created by alexamorales on 8/6/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Match : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *jobTitle;
@property (nonatomic, strong) NSString *jobURL;

@end

NS_ASSUME_NONNULL_END
