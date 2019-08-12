//
//  WebViewController.h
//  seam
//
//  Created by festusojo on 8/9/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (strong, nonatomic) NSURL* jobURL;

@end

NS_ASSUME_NONNULL_END
