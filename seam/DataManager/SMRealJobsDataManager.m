//
//  SMRealJobsDataManager.m
//  seam
//
//  Created by laurenjle on 7/25/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "SMRealJobsDataManager.h"

@implementation SMRealJobsDataManager

//can make a url request. currently requesting data from a weather api. waiting to get access to job listings api.
- (void)fetchJobsWithCompletion:(void (^)(NSArray *, NSError *))completion{
    //store the url as an NSString
    NSString *urlString = @"https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22";
    
    //create NSURL object initialized with a provided URL string
    NSURL *url = [NSURL URLWithString:urlString];
    
    //make a a URL load request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //defines the behavior and policies to use when uploading and downloading data.(use this object to configure the timeout values, caching policies, connection requirements, and other types of information)
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //provide an API for downloading data from and uploading data to endpoints indicated by URLs
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    //A data task returns data directly to the app (in memory) as one or more NSData objects
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            //JSON is a format that encodes objects in a string. Serialization means to convert an object into that string, and deserialization is its inverse operation.
            NSArray *serializedData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error][@"main"];
            NSLog(@"read serialized data from url request: %@", serializedData);
        } else {
            NSLog(@"unable to make url request");
        }
    }];
    [task resume];
}

//add jobs users swipe right on to their personal array
- (void)onApplyForJob:(NSArray*)alteredApplicantArray{
    
}

//add jobs users swipe left on to their personal array
- (void)onRejectJob:(NSArray*)alteredApplicantArray{
    
}

//removes job from general job array
- (void)onUninterestedInJob:(NSArray*)shorterJobArray{
    
}

//fetch jobs on main matching screen upon loading
- (void)fetchMatchesWithCompletion:(void (^)(NSArray *matches, NSError *error))completion{
    
}

@end
