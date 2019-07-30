//
//  ProfileViewController.m
//  seam
//
//  Created by alexamorales on 7/18/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "ProfileViewController.h"

#import "Parse/Parse.h"
#import "PFUser+SMUserProfile.h"
#import "ProgressHUD.h"
#import "SMUserProfile.h"

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
    self.userProfile = PFUser.currentUser.userProfile;
    
    //loads user's info from Parse and passes it into textViews
    self.about.text = self.userProfile.about;
    self.education.text = self.userProfile.education;
    self.jobTitle.text = self.userProfile.title;
    self.company.text = self.userProfile.company;
    self.jobDescription.text = self.userProfile.jobDescription;
    self.skills.text = self.userProfile.skills;
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

//show alert controller
-(void)showAlertViewController:(BOOL *)value{
    if (value == NO) {
        
        //alert
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Profile save failed"
                                                                       message:@"Please try again later"
                                                                preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                         }];
        
        // add the OK action to the alert controller
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
            
        }];
    }
    else {
        NSLog(@"Saved successfully");
    }
}

- (IBAction)onSave:(id)sender {
    SMUserProfile *updatedProfile = PFUser.currentUser.userProfile;
    
    //passes values in text views into the instaniated profile called updatedProfile
    updatedProfile.about = self.about.text;
    updatedProfile.education = self.education.text;
    updatedProfile.title = self.jobTitle.text;
    updatedProfile.company = self.company.text;
    updatedProfile.jobDescription = self.jobDescription.text;
    updatedProfile.skills = self.skills.text;
    PFUser.currentUser.userProfile = updatedProfile;
    
    //this is the HUD being called, it's dismissed in Post.m
    [ProgressHUD show:@"Please wait..."];
    
    //saves in background and allows for error checking
    [PFUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error){
            [ProgressHUD dismiss];
            [self showAlertViewController:false];
        }
        else{
            NSString *text = updatedProfile.about;
            NSLog(@"%@", text);
            [ProgressHUD dismiss];
            [self showAlertViewController:true];
        }
    }];
}

//press logout button, this action calls the method that eraes the user then dismisses
- (IBAction)logout:(id)sender {
    [self logoutUser];
}

@end
