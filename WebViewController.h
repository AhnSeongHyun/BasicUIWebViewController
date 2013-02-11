//
//  WebViewController.h
//  GoodRestaurant
//
//  Created by an seonghyun on 13. 2. 11..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
<UIWebViewDelegate>
{
    UIWebView *webView;
    UIProgressView *progressView;
    UILabel *webTitle;
    UIImageView *closeView;
    
    float progressAnimationFactor;
}

@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, retain) UIProgressView *progressView;
@property(nonatomic, retain) UILabel *webTitle;
@property(nonatomic, retain) UIImageView *closeView;
@property float progressAnimationFactor;

-(void)reload:(NSString*)url;


@end
