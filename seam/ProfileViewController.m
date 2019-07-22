//
//  ProfileViewController.m
//  seam
//
//  Created by alexamorales on 7/18/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *about;
@property (weak, nonatomic) IBOutlet UITextView *education;
@property (weak, nonatomic) IBOutlet UITextView *jobTitle;
@property (weak, nonatomic) IBOutlet UITextView *company;
@property (weak, nonatomic) IBOutlet UITextView *jobDescription;
@property (weak, nonatomic) IBOutlet UITextView *skills;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _about.delegate = self;
//    _education.delegate = self;
//    _jobTitle.delegate = self;
//    _company.delegate = self;
//    _jobDescription.delegate = self;
//    _skills.delegate = self;
    
_saveButton.hidden = YES;
}

//- (void)textViewDidBeginEditing:(UITextView *) editPressed{
//    // user taps text view to type text
//}
//
//- (void)textViewDidEndEditing:(UITextView *) saveData {
//    //handle text editing finished the saved button
//}

- (IBAction)editPressed:(id)sender {
    _about.editable = YES;
    _education.editable = YES;
    _jobTitle.editable = YES;
    _company.editable = YES;
    _jobDescription.editable = YES;
    _skills.editable = YES;
    _saveButton.hidden = NO;
}
- (IBAction)saveData:(id)sender {
    _about.editable = NO;
    _education.editable = NO;
    _jobTitle.editable = NO;
    _company.editable = NO;
    _jobDescription.editable = NO;
    _skills.editable = NO;
    _saveButton.hidden = YES;
}

- (IBAction)addPhotoClique:(id)sender {
}

@end
