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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.

    [self alertTrigger];
    _currentCardIndex = 2; //index for _jobs, since we initially created 2 cards
    
    //setting the array of jobs we defined in the interface to the jobListings accessed from the SMFakeJobsDataManager
    _realJobListings = [[NSMutableArray alloc] init];
    [[SMJobsDataManagerProvider sharedDataManager] fetchJobsWithCompletion:^(NSArray *realJobListings, NSError *error)
     {
         if (realJobListings)
         {
             self.jobs = realJobListings; //an array of dictionaries
             
             //create first card
             NSLog(@"about to make first card, at index: %d", _currentCardIndex);
             _backCard = [self createSingleCardWithJobListingIndex:0]; //create 1st card
             _frontCard = [self createSingleCardWithJobListingIndex:1]; //create 2nd card
             
             //order of view hierarchy matters. adding in subviews is like a stack.
            [self.view addSubview:_backCard];
            [self.view addSubview:_frontCard]; //stacks on top
         }
         else
         {
             NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
         }
     }];
}

- (void)alertTrigger{
    PFQuery *query = [PFQuery queryWithClassName:@"SMMatches"];
    [query whereKey:@"userPointer" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *a, NSError *error) {
        if (query) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome Back"
                                                                           message:@"You have matches. Go check them out!"
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                             }];
            // add the OK action to the alert controller
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:^{
            }];
        }
    }];
}


- (void)noMoreCardsAlert{
    //alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Currently no more jobs"
                                                                   message:@"Please update your profile to view more job options or wait for new job postings. "
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // handle response here.
                                                     }];
    
    // add the OK action to the alert controller
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
        
        // optional code for what happens after the alert controller has finished presenting
    }];
}
//for reusable, only used TWICE to make first and second card
- (UIView*)createSingleCardWithJobListingIndex:(int)jobListIndex{
    if (jobListIndex >= [_jobs count]-1 ){
       return nil;
        NSLog(@"GREATER THAN NUMBER OF JOBS AT THIS POINT");
    }
    //swiping yes or no
    // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    
    //set the delegate to this view controller in order to detect the swiping direction per view to work
    options.delegate = self;
    
    //define size of card. we are using the placeholderView's frame from the storyboard
    //let image serve as a card for now. Need to connect this to the views which will be connect to SMJobListing.h model
    MDCSwipeToChooseView *view = [[MDCSwipeToChooseView alloc] initWithFrame:self.placeholderView.frame
                                                                     options:options];
    [self changeDataOnCardAtIndex:jobListIndex atCard:view];
    return view;
}

- (void)changeDataOnCardAtIndex:(int) ind atCard:(MDCSwipeToChooseView *) theView{
    if (ind < [self.jobs count]){
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
    //first card is now second card
    //second card is a new card
    UIView *newCard = [self createSingleCardWithJobListingIndex: _currentCardIndex];
    _frontCard = _backCard;
    _backCard = newCard;
    
    if (_backCard == nil){ //at createSingleCard.. method, it returns nil if there are no more cards
        NSLog(@"no more cards");
        [self noMoreCardsAlert];
    }
    else{ //no more cards or data so:
        [self.view insertSubview:_backCard aboveSubview:_backgroundView];
        
        //reset where the first card will be placed after it was swiped away
        _backCard.frame = self.placeholderView.frame;
        _currentCardIndex++;
        
    }
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
