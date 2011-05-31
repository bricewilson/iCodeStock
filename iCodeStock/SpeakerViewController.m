//
//  SpeakerViewController.m
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import "SpeakerViewController.h"
#import "Speaker.h"
#import "Constants.h"

@implementation SpeakerViewController

@synthesize speaker;
@synthesize nameLabel;
@synthesize companyLabel;
@synthesize twitterIDLabel;
@synthesize websiteLabel;
@synthesize speakerImage;
@synthesize speakerBioWebView;
@synthesize websiteTextView;
@synthesize waitIndicator;
@synthesize dataWaitIndicator;

- (void) dataRefreshStarted
{
	[self.dataWaitIndicator startAnimating];
	[self.dataWaitIndicator setHidden:NO];
}

- (void) sessionsUpdated
{
	[self.dataWaitIndicator stopAnimating];
	[self.dataWaitIndicator setHidden:YES];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

// this methods loads URLs in Safari instead of the UIWebView
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
	
	[self.dataWaitIndicator setHidden:YES];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataRefreshStarted)
                                                 name:DataRefreshMessage 
                                               object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionsUpdated)
                                                 name:SessionsUpdatedMessage 
                                               object:nil];
	
	self.title = @"Speaker";
	
	// begin downloading speaker image asynchronously
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	[queue addOperationWithBlock:^{
		NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.speaker.photoURL]];
		UIImage* image = [[UIImage alloc] initWithData:imageData];
		[imageData release];
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[waitIndicator stopAnimating];
			self.speakerImage.image = image;
		}];
		[image release];
	}];
	[queue release];
	
	self.nameLabel.text = self.speaker.name;
	self.companyLabel.text = self.speaker.company;
	if (self.speaker.twitterID)
	{
		self.twitterIDLabel.text = [NSString stringWithFormat:@"%@ (twitter)", self.speaker.twitterID];
	}
	else
	{
		self.twitterIDLabel.text = nil;
	}
	self.websiteLabel.text = self.speaker.website;
	self.websiteTextView.text = self.speaker.website;
	[self.speakerBioWebView loadHTMLString:self.speaker.bio baseURL:nil];
	[self.speakerBioWebView setBackgroundColor:[UIColor clearColor]];
	[self.speakerBioWebView setOpaque:NO];

	
	UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"iCodeStockBackground.png"]];
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
	[speaker release];
	[nameLabel release];
	[companyLabel release];
	[twitterIDLabel release];
	[websiteLabel release];
	[speakerImage release];
	[speakerBioWebView release];
	[websiteTextView release];
	[dataWaitIndicator release];
    [super dealloc];
}

@end
