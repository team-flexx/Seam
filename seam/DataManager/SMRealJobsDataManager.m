//
//  SMRealJobsDataManager.m
//  seam
//
//  Created by laurenjle on 7/25/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMRealJobsDataManager.h"

#import "Parse/Parse.h"
#import "PFUser+SMUserProfile.h"
#import "SMApplicantSwipeLeft.h"
#import "SMApplicantSwipeRight.h"
#import "SMUserProfile.h"

@interface SMRealJobsDataManager ()

@property (nonatomic, strong) NSMutableArray *realJobs; //stores real jobs from url request
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *applicantSwipes;
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *applicantRejections;
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *employerSwipes;
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *matchArray;
@property (nonatomic, strong) NSMutableArray<SMJobListing *> *jobStack;

@end

@implementation SMRealJobsDataManager

- (instancetype)init
{
    if (self = [super init])
    {
        _applicantSwipes = [NSMutableArray new];
        _applicantRejections = [NSMutableArray new];
        _employerSwipes = [NSMutableArray new];
        _matchArray = [NSMutableArray new];
        _jobStack = [NSMutableArray new];
    }
    return self;
}

- (void)fetchJobsWithCompletion:(void (^)(NSArray *realJobListings, NSError *error))completion {
    NSMutableArray *realJobListings = [NSMutableArray new];
    NSURLRequest* request = [self beginURLRequest];
    
    //provide an API for downloading data from and uploading data to endpoints indicated by URLs
    NSURLSession *session =
    [NSURLSession
     sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
     delegate:nil
     delegateQueue:[NSOperationQueue mainQueue]];
    
    //A data task returns data directly to the app (in memory) as one or more NSData objects
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error){
            NSLog(@"unable to make url request");
            //TODO: SHOW PROMPT
            return;
        }
          //JSON is a format that encodes objects in a string. Serialization means to convert an object into that string, and deserialization is its inverse operation.
        NSArray *serializedData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error][@"listings"][@"listing"];
        [self transformJSONDataToDict:serializedData WithJobListings:realJobListings];
        completion(realJobListings, nil);
        }
    ];
    [task resume];
}

- (NSURLRequest*)beginURLRequest{
    //store the url as an NSString
    NSString *urlString = @"https://authenticjobs.com/api/?api_key=6a1045b081eb8914a0b3fc5283a0e046&method=aj.jobs.get&format=json&method=aj.jobs.search";
    
    //create NSURL object initialized with a provided URL string
    NSURL *url = [NSURL URLWithString:urlString];
    
    //make a a URL load request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}
- (void)transformJSONDataToDict:(NSArray*)theData WithJobListings:(NSMutableArray*)theJobListings{
    for (id obj in theData)
    {
        SMJobListing *aRealJob =
        [[SMJobListing alloc] init];
        aRealJob.companyName = obj[@"company"][@"name"];
        aRealJob.jobDescription = obj[@"description"];
        aRealJob.jobID = obj[@"id"];
        aRealJob.locationName = obj[@"company"][@"location"][@"name"];
        aRealJob.title = obj[@"title"];
        NSString* resultURL = [NSString stringWithFormat:obj[@"url"]];
        aRealJob.jobURL = resultURL;
        
        if ([PFUser.currentUser.userProfile.applicantSwipes isKindOfClass:[NSNull class]] &&
            [PFUser.currentUser.userProfile.applicantRejections isKindOfClass:[NSNull class]]) {
            [theJobListings addObject:aRealJob];
        }

                if (![PFUser.currentUser.userProfile.applicantSwipes containsObject:aRealJob] &&
           ![PFUser.currentUser.userProfile.applicantRejections containsObject:aRealJob]) {
            [theJobListings addObject:aRealJob];
        }
    }
}
    
//add jobs users swipe right on to their personal array
- (void)onApplyForJob:(SMJobListing*)chosenJob{
    
    //instantiates profile and passes job into it
    SMUserProfile *updatedProfile = PFUser.currentUser.userProfile;
    NSLog(@"%@", PFUser.currentUser.username);
    
    //adds new values to chosenJob selected before saving to Parse
    chosenJob.author = [PFUser currentUser];
    chosenJob.direction = @"right";
    [chosenJob saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        //saves to separate swipeRight array
        SMApplicantSwipeRight *currentSwipe = [SMApplicantSwipeRight new];
        currentSwipe.author = chosenJob.author;
        currentSwipe.companyName = chosenJob.companyName;
        currentSwipe.jobURL = chosenJob.jobURL;
        [currentSwipe saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
            //saves applicantswipes and passes them into version on user's Parse account
            [updatedProfile.applicantSwipes addObject:chosenJob];
            [PFObject saveAllInBackground:updatedProfile.applicantSwipes block:^(BOOL succeeded, NSError *error) {
                
                PFUser.currentUser.userProfile = updatedProfile;
                
                [PFUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    NSLog(@"%@", error);
                }];
                
            }];
            
        }];
        
    }];
    
}

//add jobs users swipe left on to their personal array
- (void)onRejectJob:(SMJobListing*)chosenJob {
    
    //instantiates profile and passes job into it
    SMUserProfile *updatedProfile = PFUser.currentUser.userProfile;
    NSLog(@"%@", PFUser.currentUser.username);
    
    //adds new values to chosenJob selected before saving to Parse
    chosenJob.author = [PFUser currentUser];
    chosenJob.direction = @"left";
    [chosenJob saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        //saves to separate swipeRight array
        SMApplicantSwipeLeft *currentSwipe = [SMApplicantSwipeLeft new];
        currentSwipe.jobID = chosenJob.jobID;
        currentSwipe.author = chosenJob.author;
        [currentSwipe saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
            //saves applicant rejections and passes them into version on user's Parse account
            [updatedProfile.applicantRejections addObject:chosenJob];
            [PFObject saveAllInBackground:updatedProfile.applicantRejections block:^(BOOL succeeded, NSError *error) {
                
                PFUser.currentUser.userProfile = updatedProfile;
                
                [PFUser.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    NSLog(@"%@", error);
                }];
                
            }];
            
        }];
        
    }];
    
}

//fetch jobs on main matching screen upon loading
- (void)fetchMatchesWithCompletion:(void (^)(NSArray *matches, NSError *error))completion {
    NSArray *matches= [NSArray new];
    completion(matches, nil);
}


//convert HTML string
- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}

@end
