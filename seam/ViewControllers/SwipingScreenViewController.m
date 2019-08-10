//
//  SwipingScreenViewController.m
//  seam
//
//  Created by laurenjle on 7/17/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SwipingScreenViewController.h"
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>
#import "SMJobCard.h"
#import "SMRealJobsDataManager.h"
#import "SMJobsDataManaging.h"
#import "SMJobsDataManagerProvider.h"
#import "SMJobListing.h"
#import <QuartzCore/QuartzCore.h> //use for converting uiview to uiimage
#import "Parse/Parse.h"

#import "Match.h"


@interface SwipingScreenViewController ()

//@property (weak, nonatomic) IBOutlet SMJobCard *cardView; //the job applicant
@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (nonatomic, strong) NSMutableArray *jobs; //stores the model, an array of JobListings
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *realJobListings;
@property (nonatomic, strong) UIView *frontCard;
@property (nonatomic, strong) UIView *backCard;
@property (nonatomic, strong) IBOutlet UIView *backgroundView; //the desk.jpg


@end

@implementation SwipingScreenViewController {
    NSUInteger _currentCardIndex; //keep track of the current view's info in viewWasChosenWithDirection method
    NSUInteger _nextCardTrackerIndex;//keep track of the current view's info in viewWasChosenWithDirection method
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //setting the array of jobs we defined in the interface to the jobListings accessed from the SMFakeJobsDataManager
    
    _realJobListings = [[NSMutableArray alloc] init];
    
    _currentCardIndex = 0; //index of job listing array
    _nextCardTrackerIndex = 1;
    
    [[SMJobsDataManagerProvider sharedDataManager] fetchJobsWithCompletion:^(NSArray *realJobListings, NSError *error)
     {
         if (realJobListings)
         {
             self.jobs = realJobListings; //an array of dictionaries
             
             //create first card
             NSLog(@"about to make first card, at index: %d", _currentCardIndex);
             _frontCard = [self createSingleCardWithJobListingIndex:_currentCardIndex]; //create 1st card
             _backCard = [self createSingleCardWithJobListingIndex:_nextCardTrackerIndex]; //create 2nd card
         }
         else
         {
             NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
         }
     }];
}

- (void)modifyReusableCards{
    NSLog(@"creating stack of cards, something may have deleted");
    if(_currentCardIndex == [_jobs count]) //BASE CASE
    {
        NSLog(@"done");
    }
    else
    {
        if (_currentCardIndex == _nextCardTrackerIndex)
        {
            NSLog(@"change data on card because one just got deleted");
            _nextCardTrackerIndex++;
        }
    }
}

//for reusable, only used TWICE to make first and second card
- (UIView*)createSingleCardWithJobListingIndex:(int)jobListIndex{
    //swiping yes or no
    // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    //set the delegate to this view controller in order to detect the swiping direction per view to work
    options.delegate = self;
    //text box you see at the top left or right corner of card in the home screen when you're swiping
    options.likedText = @"Get job";
    options.likedColor = [UIColor blueColor];
    options.nopeText = @"Delete";
    
    //define size of card. we are using the placeholderView's frame from the storyboard
    //let image serve as a card for now. Need to connect this to the views which will be connect to SMJobListing.h model
    MDCSwipeToChooseView *view = [[MDCSwipeToChooseView alloc] initWithFrame:self.placeholderView.frame
                                                                     options:options];
    
    [self changeDataOnCardAtIndex:jobListIndex atCard:view];
    [self.view addSubview:view];
    return view;
}

- (void)changeDataOnCardAtIndex:(int) ind atCard:(MDCSwipeToChooseView *) theView{
    // check index
    
    SMJobCard *theCardView = [[SMJobCard alloc] init];
    SMJobListing *jobPointer = self.jobs[ind];
    
    //define the cardView's frame using the size we made the placeHolderView in Main.storyboard
    theCardView.frame = self.placeholderView.frame;
    
    theCardView.jobTitleLabel.text = jobPointer.title;
    theCardView.companyLabel.text = jobPointer.companyName;
    theCardView.locationLabel.text = jobPointer.locationName;
    theCardView.jobScheduleLabel.text = jobPointer.schedule;
    theCardView.jobTypeLabel.text = jobPointer.typeOfJob;
    theCardView.jobPerks.text = jobPointer.perks;
    theCardView.jobCategory.text = jobPointer.category;
    
    
    //convert uiview to uiimage in order for it to show up as a card
    //use the view file we created with CardViewXIB.xib and SMJobCard.m
    theView.imageView.image = [self imageWithView:theCardView];
}

//NOTE: these methods work after you set the options.delegate = self in viewDidLoad. this would add it to array of applicant_swipes
// Sent before a choice is made
- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction {
    return YES;
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft)
    {
        [[SMJobsDataManagerProvider sharedDataManager] onRejectJob:self.jobs[_currentCardIndex]];
        NSLog(@"Photo deleted!");
        [self switchAndMoveFrontAndBackCards];
    }
    else
    {
        [[SMJobsDataManagerProvider sharedDataManager] onApplyForJob:self.jobs[_currentCardIndex]];
        NSLog(@"Photo saved!");
        [self switchAndMoveFrontAndBackCards];
    }
}

-(void)switchAndMoveFrontAndBackCards{
    //reset where the first card will be placed after it was swiped away
    _frontCard.frame = self.placeholderView.frame;
    
    //NEW:
    [UIView animateWithDuration:0.16 animations:^{
        _frontCard.transform = CGAffineTransformIdentity;
        _frontCard.center = [_placeholderView superview].center;
    }];
    
    
    [UIView animateWithDuration:0.16 animations:^{
        _backCard.transform = CGAffineTransformIdentity;
        _backCard.center = [_placeholderView superview].center;
    }];
    
    int nextNextCardIndex = _nextCardTrackerIndex++;
    [self changeDataOnCardAtIndex:nextNextCardIndex atCard:_frontCard];
    
    //add the _firstCard back to subview
    //retains _frontCard, which is needed to reuse this _frontCard view after removing it from the view hierarchy (from pod)
    [self.view addSubview:_frontCard];
    
    //Inserts a view among the view’s subviews so it’s displayed immediately above or below another view
    //[self.view sendSubviewToBack:_frontCard];
    [self.view insertSubview:_frontCard aboveSubview:_backgroundView];
    
    //first card is now second card
    //second card is what used to be the first card
    UIView *temp = _frontCard;
    _frontCard = _backCard;
    _backCard = temp;
    
    _currentCardIndex++;
    [self modifyReusableCards];
}

//convert uiiview to uiimage
- (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
