//
//  MatchesViewController.m
//  seam
//
//  Created by alexamorales on 7/23/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "MatchesViewController.h"
#import "Match.h"
#import <Parse/Parse.h>

@interface MatchesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;

@end

@implementation MatchesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void) callArrayWithMatches {
//     NSString *myMatch = self.companyNameLabel.text;
//       load and refresh
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    MatchCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MatchCell"];
//    Match *match = self.matches[indexPath.row];
//    cell.theNameLabel.text = matches[@"companyName"];
//    return cell;
//
//}
//
//- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.matches.count;
//}

@end
