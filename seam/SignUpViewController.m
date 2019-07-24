//
//  SignUpViewController.m
//  seam
//
//  Created by alexamorales on 7/22/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
            NSLog(@"Error: %@", error.localizedDescription);
            //we want to actually tell the user what they did wrong, so let's use a Alert Controller embedded in code to do so
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Invalid Information"
                                                                           message:[NSString stringWithFormat:@"%@", error.localizedDescription]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            //this creates an alert action that tells the user if there's something wrong and what it is
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:^{}];
        } else {
            NSLog(@"User registered successfully");
            // manually segue to logged in view
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//the Cancel button is the action, you dismiss the animation and go back to login origional page
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//the create actount button is this action, then you call the registeruser methos through the action
- (IBAction)registerUser:(id)sender {
    [self registerUser];
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
