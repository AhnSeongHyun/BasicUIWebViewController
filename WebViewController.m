//
//  WebViewController.m
//  GoodRestaurant
//
//  Created by an seonghyun on 13. 2. 11..
//  Copyright (c) 2013년 an seonghyun. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize progressAnimationFactor, progressView, webTitle, webView, closeView; 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        UIImageView *menuView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menu.png"]]autorelease];
        menuView.frame = CGRectMake(0,0,320, 44);
        
        webTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 42)];
        webTitle.backgroundColor = [UIColor clearColor];
        webTitle.textAlignment = NSTextAlignmentCenter;
        webTitle.textColor = [UIColor whiteColor];
        webTitle.font = [UIFont boldSystemFontOfSize:16];
        
        
        [menuView addSubview:webTitle];
        
        closeView = [[UIImageView alloc]initWithFrame:CGRectMake(285, 7, 30, 30)];
        closeView.image = [UIImage imageNamed:@"close.png"];
        [menuView addSubview:closeView];
        
        
        [self.view addSubview:menuView];
        
        progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(-5, 44, 340, 9)];
        [self.view addSubview:progressView];
        progressView.hidden  = true;
        
        
        // Initialization code
        webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 55, 320, 400)];
        [self.view addSubview:webView];
        webView.scalesPageToFit = true;
        webView.delegate = self;
        
        progressAnimationFactor = 0.0f;

        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)dealloc
{
    [super dealloc];
    
    
    [self.webTitle release]; 
    [self.closeView release]; 
    [self.webView release]; 
    [self.progressView release]; 
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reload:(NSString*)url
{
    
    NSURL* urlObj = [[NSURL alloc] initWithString:url];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:urlObj];
    progressView.hidden  = false;
    progressAnimationFactor = 0.1f;
    
    
    
    self.webView.frame = CGRectMake(0, 55, 320, 400);
    
    
    
    [webView loadRequest: urlRequest];
    [urlObj release];
    [urlRequest release];
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint closeViewPoint = [touch locationInView:closeView];
    
    
    if(closeViewPoint.x >0 && closeViewPoint.y>0)
    {
        [self close];
    }
    
}


-(void) close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark UIWebView Delegate



- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if(progressAnimationFactor <0.3)
    {
        progressAnimationFactor = 0.3f;
        [self.progressView setProgress:progressAnimationFactor animated:true];
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    progressAnimationFactor = 1.0f;
    [self.progressView setProgress:progressAnimationFactor animated:true];
    
    progressView.hidden  = true;
    self.webView.frame = CGRectMake(0, 44, 320, 400);
    
    
    NSString* titletxt = [self.webView stringByEvaluatingJavaScriptFromString: @"document.title"];
    self.webTitle.text = titletxt;
     
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    progressAnimationFactor += 0.1f;
    [self.progressView setProgress:progressAnimationFactor animated:true];
    
    return YES;
}



@end
