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
    
    [self.refreshIndicator startAnimating];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(cellForRowAtIndexPath:) forControlEvents:(UIControlEventValueChanged)];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
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
                                }];
    [self.refreshControl endRefreshing];
    [self.refreshIndicator stopAnimating];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MatchCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MatchCell"];
    cell.jobURLTextView.delegate = self;
    Match *theMatch = self.filteredMatches[indexPath.row];
    cell.theNameLabel.text = theMatch[@"companyName"];
    cell.jobTitleLabel.text = theMatch[@"title"];
    cell.jobURLTextView.text = theMatch[@"jobURL"];
    cell.jobURLTextView.editable = NO;
    cell.jobURLTextView.dataDetectorTypes = UIDataDetectorTypeAll;
    
//    cell.jobURLTextView.delegate=self;
//    cell.jobURLTextView.selectable=YES;
//    cell.jobURLTextView.dataDetectorTypes = UIDataDetectorTypeLink;
//
//    NSURL *url = [NSURL URLWithString:theMatch[@"jobURL"]];
//    NSURLRequest *req = [NSURLRequest requestWithURL:url];
//    [_webView loadRequest:req];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.estimatedRowHeight = 100.0;
    tableView.rowHeight = UITableViewAutomaticDimension;
    return tableView.estimatedRowHeight;
    return tableView.rowHeight;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked){
        //open it on browser if you want to open it in same web view remove return NO;
        NSURL *url = request.URL;
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            UIApplication *application = [UIApplication sharedApplication];
            [application openURL:url options:@{} completionHandler:nil];
        }
        return NO;
    }
    return YES;
    
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

@end

