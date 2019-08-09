//
//  MatchesViewController.m
//  seam
//
//  Created by alexamorales on 7/23/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "MatchesViewController.h"
#import "Match.h"
#import "MatchCell.h"
#import "SMFakeJobsDataManager.h"
#import "SMJobsDataManagerProvider.h"
#import <Parse/Parse.h>

@interface MatchesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *matches;

@end

@implementation MatchesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [[SMJobsDataManagerProvider sharedDataManager] fetchJobsWithCompletion:^(NSArray *realJobListings, NSError *error)
     {
         if (realJobListings)
         {
             self.matches = [NSMutableArray arrayWithArray:realJobListings]; //an array of dictionaries
         }
         else
         {
             NSLog(@" Error getting home timeline: %@", error.localizedDescription);
         }
                      [self.tableView reloadData];
     }];
}

- (void) callArrayWithMatches {
//     NSString *myMatch = self.companyNameLabel.text;
//       load and refresh
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MatchCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MatchCell"];
    Match *theMatch = self.matches[indexPath.row];
//    cell.match = theMatch;
    cell.theNameLabel.text = theMatch[@"companyName"];
    return cell;

}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%d", self.matches.count);
    return self.matches.count;
}

@end
