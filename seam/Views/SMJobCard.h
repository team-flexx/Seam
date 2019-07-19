//
//  SMJobCard.h
//  seam
//
//  Created by laurenjle on 7/17/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMJobCard : UIView

@property (weak, nonatomic) IBOutlet UILabel *jobDescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobScheduleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dutiesLabel;

@end

NS_ASSUME_NONNULL_END
