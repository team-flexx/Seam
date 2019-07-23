//
//  ProfileViewController.m
//  seam
//
//  Created by alexamorales on 7/18/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"

@interface ProfileViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *about;
@property (weak, nonatomic) IBOutlet UITextView *education;
@property (weak, nonatomic) IBOutlet UITextView *jobTitle;
@property (weak, nonatomic) IBOutlet UITextView *company;
@property (weak, nonatomic) IBOutlet UITextView *jobDescription;
@property (weak, nonatomic) IBOutlet UITextView *skills;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *jobFilters;

@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
_saveButton.hidden = YES;
_jobFilters.hidden =YES;
}
- (IBAction)editPressed:(id)sender {
    _about.editable = YES;
    _education.editable = YES;
    _jobTitle.editable = YES;
    _company.editable = YES;
    _jobDescription.editable = YES;
    _skills.editable = YES;
    _saveButton.hidden = NO;
    _jobFilters.hidden = NO;
}
- (IBAction)saveData:(id)sender {
    _about.editable = NO;
    _education.editable = NO;
    _jobTitle.editable = NO;
    _company.editable = NO;
    _jobDescription.editable = NO;
    _skills.editable = NO;
    _saveButton.hidden = YES;
    _jobFilters.hidden =YES;
}
//method to log out
- (void)logoutUser{
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        [self dismissViewControllerAnimated:YES completion:nil];
    }];}
//press logout button, this action calls the method that eraes the user then dismisses
- (IBAction)logout:(id)sender {
    [self logoutUser];
}
@end
