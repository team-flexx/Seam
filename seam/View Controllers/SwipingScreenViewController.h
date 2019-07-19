//
//  SwipingScreenViewController.h
//  seam
//
//  Created by laurenjle on 7/17/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMJobCard.h"
#import "SMJobListing.h"
NS_ASSUME_NONNULL_BEGIN
//#import "SMJobCard.h"

@interface SwipingScreenViewController : UIViewController<MDCSwipeToChooseDelegate>

@property (nonatomic, strong) SMJobListing *currentJobListing;
@property (nonatomic, strong) SMJobCard *frontCardView;
@property (nonatomic, strong) SMJobCard *backCardView;
@end

NS_ASSUME_NONNULL_END
