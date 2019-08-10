//
//  MatchCell.h
//  seam
//
//  Created by alexamorales on 8/6/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Match.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatchCell : UITableViewCell

//@property (strong, nonatomic) IBOutlet UILabel *theNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *theNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *jobURLTextView;

@property (strong, nonatomic) Match *match;

@end

NS_ASSUME_NONNULL_END
