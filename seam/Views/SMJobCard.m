//
//  SMJobCard.m
//  seam
//
//  Created by laurenjle on 7/17/19.
//  Copyright © 2019 codepath. All rights reserved.
//
//#import "CardViewXIB.xib"
#import "SMJobCard.h"

@interface SMJobCard()


@end


@implementation SMJobCard
//the three methods below overides both initializers and calls our own customInit
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self customInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self customInit];
    }
    return self;
}

-(void) customInit
{
    [[NSBundle mainBundle] loadNibNamed:@"CardViewXIB" owner:self options:nil];
    [self addSubview:self.cardDetailsView];
    self.cardDetailsView.frame = self.bounds;
}
@end
