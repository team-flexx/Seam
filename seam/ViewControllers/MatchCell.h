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

//@protocol CellDelegate <NSObject>
//- (void)didClickOnCellAtIndex:(NSInteger)cellIndex withData:(id)data;
//@end

@interface MatchCell : UITableViewCell

//@property (strong, nonatomic) IBOutlet UILabel *theNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *theNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *webButton;

@property (strong, nonatomic) Match *match;

@end

NS_ASSUME_NONNULL_END
