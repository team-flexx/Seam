//
//  SignUpViewController.m
//  seam
//
//  Created by alexamorales on 7/22/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SignUpViewController.h"

#import "AppDelegate.h"
#import "Parse/Parse.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//method for signing up user
- (void)registerUser {
    
    //  initialize a user object
    //with parse
    PFUser *newUser = [PFUser user];

    // set user properties
    newUser.username = self.username.text;
    newUser.email = self.email.text;
    newUser.password = self.password.text;

    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {

            //alert
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Not able to create your account"
                                                                           message:@"Username alread taken or email address format invalid, please try again"
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
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
//            [self performSegueWithIdentifier:@"showMainView" sender:nil];
            
            // manually set new root VC 
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITabBarController *rootViewController = [sb instantiateViewControllerWithIdentifier:@"TabBarController"];
            [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];
        }
    }];
}

//the Cancel button is the action, you dismiss the animation and go back to login origional page
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//the create actount button is this action, then you call the registeruser methos through the action
- (IBAction)registerUser:(id)sender {
    [self registerUser];
}

@end
