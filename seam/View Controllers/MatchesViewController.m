//
//  MatchesViewController.m
//  seam
//
//  Created by alexamorales on 7/23/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "MatchesViewController.h"
#import <Parse/Parse.h>

@interface MatchesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MatchesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void) callArrayWithMatches {
     NSString *myMatch = self.companyNameLabel.text;
    
    //call the array from parse
    //bring back the name of company
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    [query getObjectInBackgroundWithId:@"xWMyZ4YEGZ" block:^(PFObject *gameScore, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"%@", gameScore);
    }];
    // [myObject fetch];
}



@end
