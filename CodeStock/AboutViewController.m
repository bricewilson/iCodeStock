//
//  AboutViewController.m
//  CodeStock
//
//  Created by Brice Wilson on 4/24/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import "AboutViewController.h"
#import "Constants.h"


@implementation AboutViewController

@synthesize codeStockDescWebView;

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
	
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

	[self.codeStockDescWebView loadHTMLString:CodeStockDescHtml baseURL:nil];
	[self.codeStockDescWebView setBackgroundColor:[UIColor clearColor]];
	[self.codeStockDescWebView setOpaque:NO];

	UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"iCodeStockBackgroundAbout.png"]];
	self.view.backgroundColor = background;
	[background release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
	[codeStockDescWebView release];
    [super dealloc];
}

@end
