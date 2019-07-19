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
#import "SMJobListing.h"

@interface SwipingScreenViewController ()
@property (weak, nonatomic) IBOutlet SMJobCard *cardView; //the job applicant

@property (nonatomic, strong) NSMutableArray *jobs; //stores the model, an array of JobListings
@end

@implementation SwipingScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //set cardView delegate and dataSource to self
    
    //setting the array of jobs we defined in the interface to the jobListings accessed from the SMFakeJobsDataManager
    [[SMFakeJobsDataManager shared] fetchJobsWithCompletion:^(NSArray *jobListings, NSError *error) {
        if (jobListings){
            self.jobs = jobListings; //an array of dictionaries
            //test to see if self.jobs successfully contains data
            for (SMJobListing *job1 in jobListings) {
                NSString *text = job1.jobCompany;
                NSLog(@"%@", text);
            }
        }
        else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }}];
    
        
    //swiping yes or no
    // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    //text box you see at the top left or right corner of card in the home screen when you're swiping
    options.likedText = @"Get job";
    options.likedColor = [UIColor blueColor];
    options.nopeText = @"Delete";
    options.onPan = ^(MDCPanState *state){
        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
            NSLog(@"Let go now to delete the photo!");
        }
    };
    
    //let image serve as a card for now. Need to connect this to the views which will be connect to SMJobListing.h model
    MDCSwipeToChooseView *view = [[MDCSwipeToChooseView alloc] initWithFrame:self.view.bounds
                                                                     options:options];
    view.imageView.image = [UIImage imageNamed:@"photo"]; //used photo.png as a card placeholder for swipign
    [self.view addSubview:view];
    
    
    //testing fake data
    //create a SMFakeJobsDataManager.h object
    //usually this is where we dequeue a reusable cell but for now we are focusing on passing data to one card
    SMJobListing *jobPointer = self.jobs[0];
    _cardView.jobDescriptionLabel.text = jobPointer.jobDescription;
    _cardView.jobScheduleLabel.text = jobPointer.dates;
    _cardView.locationLabel.text = jobPointer.location;
    _cardView.dutiesLabel.text = jobPointer.duties;
}

//user didn't fully swipe left or right
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"Couldn't decide, huh?");
}

//need to find when this runs so we know when to add it to array of applicant_swipes
// Sent before a choice is made. Cancel the choice by returning `NO`. Otherwise return `YES`.
- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        return YES;
    } else {
        // Snap the view back and cancel the choice.
        [UIView animateWithDuration:0.16 animations:^{
            view.transform = CGAffineTransformIdentity;
            view.center = [view superview].center;
        }];
        return NO;
    }
}


// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Photo deleted!");
    } else {
        NSLog(@"Photo saved!");
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
