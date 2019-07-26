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
#import "SMFakeJobsDataManager.h"
#import "SMJobsDataManaging.h" 
#import "SMJobListing.h"
#import <QuartzCore/QuartzCore.h> //use for converting uiview to uiimage
#import "Parse/Parse.h"

@interface SwipingScreenViewController ()

//@property (weak, nonatomic) IBOutlet SMJobCard *cardView; //the job applicant
@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (nonatomic, strong) NSMutableArray *jobs; //stores the model, an array of JobListings

@end

@implementation SwipingScreenViewController {
    NSUInteger _currentCardIndex; //keep track of the current view's info in viewWasChosenWithDirection method
    NSUInteger _currentCardTrackerIndex;//keep track of the current view's info in viewWasChosenWithDirection method
    NSUInteger _viewBeforeCurrentViewHierarchyIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //setting the array of jobs we defined in the interface to the jobListings accessed from the SMFakeJobsDataManager
    _currentCardIndex=0;
    _currentCardTrackerIndex=1;
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
    [[SMFakeJobsDataManager shared] fetchJobsWithCompletion:^(NSArray *jobListings, NSError *error)
    {
        if (jobListings)
        {
            self.jobs = jobListings; //an array of dictionaries
            //test to see if self.jobs successfully contains data
            for (SMJobListing *job1 in jobListings)
            {
                NSString *text = job1.jobCompany;
                NSLog(@"%@", text);
            }
        }
        else
        {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    
    //making URL request
    [[SMRealJobsDataManager shared] fetchJobs];
    
    //create first card
    NSLog(@"about to make first card, at index: %d", _currentCardIndex);
    [self createSingleCardWithJobListingIndex:_currentCardIndex];
    [self createStackOfCards];
}

-(void) createStackOfCards{
        NSLog(@"something may have deleted");
    if(_currentCardIndex == [_jobs count])
    {
        NSLog(@"done");
    }
    else
    {
        NSLog(@"did it go through");
        if (_currentCardIndex == _currentCardTrackerIndex)
        {
            _currentCardTrackerIndex++;
            [self createSingleCardWithJobListingIndex:_currentCardIndex];
        }
    }
}
-(void) createSingleCardWithJobListingIndex:(int) jobListIndex{
    NSLog(@"got in");
    //swiping yes or no
    // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    //set the delegate to this view controller in order to detect the swiping direction per view to work
    options.delegate = self;
    //text box you see at the top left or right corner of card in the home screen when you're swiping
    options.likedText = @"Get job";
    options.likedColor = [UIColor blueColor];
    options.nopeText = @"Delete";
//    options.onPan = ^(MDCPanState *state){
//        //dont think we need this
//        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
//            //NSLog(@"Let go now to delete the photo!"); //printed everytime your'e holding card down but not swiping it either direction
//        }
//    };
    
    //define size of card. we are using the placeholderView's frame from the storyboard
    //let image serve as a card for now. Need to connect this to the views which will be connect to SMJobListing.h model
    MDCSwipeToChooseView *view = [[MDCSwipeToChooseView alloc] initWithFrame:self.placeholderView.frame
                                                                     options:options];
    SMJobCard *cardView = [[SMJobCard alloc] init];
    //define the cardView's frame using the size we made the placeHolderView in Main.storyboard
    cardView.frame = self.placeholderView.frame;
    
    //testing fake data
    //create a SMFakeJobsDataManager.h object which is where data is coming from
    //usually this is where we dequeue a reusable cell but for now we are focusing on passing data to one card
    SMJobListing *jobPointer = self.jobs[jobListIndex];
    cardView.jobDescriptionLabel.text = jobPointer.jobDescription;
    cardView.jobScheduleLabel.text = jobPointer.dates;
    cardView.locationLabel.text = jobPointer.location;
    cardView.dutiesLabel.text = jobPointer.duties;
    
    
    //convert uiview to uiimage in order for it to show up as a card
    //use the view file we created with CardViewXIB.xib and SMJobCard.m
    view.imageView.image = [self imageWithView:cardView];
    [self.view addSubview:view];
    
    NSLog(@"current card index: %d", _currentCardIndex);
    NSLog(@"tracker index, %d", _currentCardTrackerIndex);
    
}

//NOTE: these methods work after you set the options.delegate = self in viewDidLoad. this would add it to array of applicant_swipes
// Sent before a choice is made. Return `YES`.
- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction {
    return YES;
}
// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft)
    {
        [[SMFakeJobsDataManager shared] onRejectJob:[NSMutableArray arrayWithObjects:self.jobs[_currentCardIndex], nil]];
        NSLog(@"Photo deleted!");
         _currentCardIndex++;
        [self createStackOfCards];
       
    }
    else
    {
        [[SMFakeJobsDataManager shared] onApplyForJob:[NSMutableArray arrayWithObjects:self.jobs[_currentCardIndex], nil]];
        NSLog(@"Photo saved!");
        _currentCardIndex++;
        NSLog(@"current card index after incfrement: %d, ", _currentCardIndex);
        [self createStackOfCards];
    }
}
//convert uiiview to uiimage
- (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
