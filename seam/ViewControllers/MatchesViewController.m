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
#import "SMJobsDataManagerProvider.h"
#import "SMJobListing.h"
#import <Parse/Parse.h>
#import "WebViewController.h"

@interface MatchesViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <SMJobListing *>  *matches;
@property (strong, nonatomic) NSMutableArray <SMJobListing *>  *filteredMatches;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *refreshIndicator;

@end

@implementation MatchesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchBar.delegate = self;
    self.matches = [NSMutableArray new];
    self.filteredMatches = self.matches;
    [self fetchCloudData];
    
    [self.refreshIndicator startAnimating];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(fetchCloudData) forControlEvents:(UIControlEventValueChanged)];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)fetchCloudData{
    //testing cloud code
    [PFCloud callFunctionInBackground:@"hello"
                       withParameters:nil
                                block:^(NSString *hi, NSError *error) {
                                    if (error) {
                                        NSLog(@"something wrong with cloud function called hello");
                                    }
                                    NSLog(@"%@", hi);
                                    
                                }];
    
    [PFCloud callFunctionInBackground:@"gettingData"
                       withParameters:@{@"username": @"user5"}
                                block:^(NSString *wat, NSError *error) {
                                    if (error) {
                                        NSLog(@"something is wrong with cloud function fridayx");
                                    }
                                    NSLog(@"heyyyy %@", wat);
                                    
                                }];
    
    //@"jobID": @"31530",
    [PFCloud callFunctionInBackground:@"didEmployerSwipe"
                       withParameters:@{@"jobID": @"31530", @"applicantIDPlainText": @"AvDGgEMpI3"}
                                block:^(NSString *wat, NSError *error) {
                                    if (error) {
                                        NSLog(@"something is wrong with cloud function fridayx");
                                    }
                                    NSLog(@"did we get the data?! %@", wat);
                                    
                                }];
    
    [PFCloud callFunctionInBackground:@"getMatchedData"
                       withParameters:@{@"user": @"AvDGgEMp"} //GET USER ID
                                block:^(NSArray<Match *> *matches, NSError *error) {
                                    if (error) {
                                        NSLog(@"something is wrong with cloud function fridayx");
                                    }
                                    //                                    NSLog(@"matched data in array of dictionaries?! %@", [wat[0] objectForKey:@"jobPointer"]);
                                    //                                    NSLog(@"look at me!%@", [[wat[0] objectForKey:@"jobPointer"] class]);
                                    for (Match* match in matches)
                                    {
                                        SMJobListing *var = [match objectForKey:@"jobPointer"];
                                        [self.matches addObject:var];
                                    }
                                    self.filteredMatches = self.matches;
                                    [self.tableView reloadData];
                                    [self.refreshControl endRefreshing];
                                    [self.refreshIndicator stopAnimating];
                                }];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MatchCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MatchCell"];
    Match *theMatch = self.filteredMatches[indexPath.row];
    cell.tag = indexPath.row;
    [cell.webButton addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.theNameLabel.text = theMatch[@"companyName"];
    cell.jobTitleLabel.text = theMatch[@"title"];
    cell.webButton.tag = indexPath.row;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.estimatedRowHeight = 100.0;
    tableView.rowHeight = UITableViewAutomaticDimension;
    return tableView.estimatedRowHeight;
    return tableView.rowHeight;
}

- (IBAction)onClick:(id)sender {
     [self performSegueWithIdentifier:@"goToChat" sender:nil];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject[@"title"] containsString:searchText];
        }];
        self.filteredMatches = [self.matches filteredArrayUsingPredicate:predicate];
        
    }
    else {
        self.filteredMatches = self.matches;
    }
    
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredMatches.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Match *theMatch = self.filteredMatches[indexPath.row];
    WebViewController *webVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WebVC"];
    webVC.jobURL = theMatch[@"jobURL"];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (IBAction)yourButtonClicked:(id)sender {
//    Match *theMatch = self.filteredMatches[indexPath.row];
//    WebViewController *webVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WebVC"];
//    webVC.jobURL = theMatch[@"jobURL"];
//    [self.navigationController pushViewController:webVC animated:YES];
}

@end

