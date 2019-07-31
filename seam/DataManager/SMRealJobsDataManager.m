//
//  SMRealJobsDataManager.m
//  seam
//
//  Created by laurenjle on 7/25/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "Parse/Parse.h"
#import "PFUser+SMUserProfile.h"
#import "SMJobListing.h"
#import "SMRealJobsDataManager.h"
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
    //store the url as an NSString
    NSString *urlString =@"https://authenticjobs.com/api/?api_key=6a1045b081eb8914a0b3fc5283a0e046&method=aj.jobs.get&format=json&method=aj.jobs.search";
    
    //create NSURL object initialized with a provided URL string
    NSURL *url = [NSURL URLWithString:urlString];
    
    //make a a URL load request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //provide an API for downloading data from and uploading data to endpoints indicated by URLs
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    //A data task returns data directly to the app (in memory) as one or more NSData objects
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (!error)
        {
          //JSON is a format that encodes objects in a string. Serialization means to convert an object into that string, and deserialization is its inverse operation.
          NSArray *serializedData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error][@"listings"][@"listing"];
          
          for (id obj in serializedData)
          {
              SMJobListing *aRealJob =
              [[SMJobListing alloc]
               initWithJobCompany:obj[@"company"][@"location"][@"name"]
               title:obj[@"title"]
               jobDescription:[self flattenHTML:obj[@"description"]]
               location:obj[@"company"][@"location"][@"name"]
               dates:@"N/A"
               duties:@"t"
               jobID:@"id"];
              
              [realJobListings addObject:aRealJob];
          }
          completion(realJobListings, nil);
        }
        else
        {
            NSLog(@"unable to make url request");
        }
    }];
    [task resume];
}

//add jobs users swipe right on to their personal array
- (void)onApplyForJob:(NSArray*)alteredApplicantArray{
    [self.applicantSwipes addObjectsFromArray:alteredApplicantArray];
    NSLog(@"applicant swipes: %@",_applicantSwipes);
    NSMutableSet* set1 = [NSMutableSet setWithArray:self.applicantSwipes];
    NSMutableSet* set2 = [NSMutableSet setWithArray:self.employerSwipes];
    [set1 intersectSet:set2];
    [self.matchArray addObject:set1];
    NSLog(@"%@",_matchArray);
}

//add jobs users swipe left on to their personal array
- (void)onRejectJob:(NSArray*)alteredApplicantArray{
    [self.applicantRejections addObjectsFromArray:alteredApplicantArray];
    NSLog(@"applicant rejections: %@",_applicantRejections);
    NSMutableSet* set1 = [NSMutableSet setWithArray:self.applicantRejections];
    [self.jobStack removeObject:set1];
    NSLog(@"reject jobs: %@",_applicantRejections);}



//fetch jobs on main matching screen upon loading
- (void)fetchMatchesWithCompletion:(void (^)(NSArray *matches, NSError *error))completion{
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

