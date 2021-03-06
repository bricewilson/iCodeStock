//
//  SessionViewController.m
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import "SessionViewController.h"
#import "Session.h"
#import "SpeakerViewController.h"
#import "Speaker.h"
#import "CodeStockAppDelegate.h"
#import "Constants.h"


@implementation SessionViewController

@synthesize currentSession;
@synthesize titleLabel;
@synthesize sessionDate;
@synthesize sessionTime;
@synthesize roomLabel;
@synthesize speakerLabel;
@synthesize speaker;
@synthesize abstractWebView;
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

// this method opens URLs in Safari instead of the UIWebView
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
	
    return YES;
}

- (void) showSpeaker
{
    SpeakerViewController *speakerVC = [[SpeakerViewController alloc] initWithNibName:@"SpeakerView" bundle:nil];
	speakerVC.speaker = self.speaker;
    [self.navigationController pushViewController:speakerVC animated:YES];
    [speakerVC release];
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

	speakerButton = [[[UIBarButtonItem alloc]           
							  initWithTitle:@"Speaker"
							  style:UIBarButtonItemStylePlain
							  target:self
							  action:@selector (showSpeaker)] autorelease];
	self.navigationItem.rightBarButtonItem = speakerButton;
    
    self.title = @"Session";
	
	CodeStockAppDelegate *app = (CodeStockAppDelegate *)[[UIApplication sharedApplication] delegate];

	NSUInteger index = [app.allSpeakers indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop)
						{
							return [((Speaker *)obj).speakerID isEqualToString:self.currentSession.speakerID];
						}];
	
	self.speaker = [app.allSpeakers objectAtIndex:index];
	
	self.titleLabel.text = self.currentSession.title;
	self.sessionDate.text = self.currentSession.startDateFormatted;
    self.sessionTime.text = [NSString stringWithFormat:@"%@ - %@", self.currentSession.startTimeFormatted, self.currentSession.endTimeFormatted];
    self.roomLabel.text = self.currentSession.room;
	self.speakerLabel.text = self.speaker.name;
	[self.abstractWebView loadHTMLString:self.currentSession.sessionAbstract baseURL:nil];
	[self.abstractWebView setBackgroundColor:[UIColor clearColor]];
	[self.abstractWebView setOpaque:NO];

	self.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
	self.titleLabel.numberOfLines = 0;
	
	UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"iCodeStockBackground.png"]];
	self.view.backgroundColor = background;
	[background release];
}

- (void)viewDidUnload
{
	self.titleLabel = nil;
	self.sessionDate = nil;
	self.sessionTime = nil;
	self.roomLabel = nil;
	self.speakerLabel = nil;
	self.abstractWebView = nil;
	self.dataWaitIndicator = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
	[currentSession release];
	[titleLabel release];
	[sessionDate release];
	[sessionTime release];
	[roomLabel release];
	[speakerLabel release];
	[speaker release];
	[abstractWebView release];
	[dataWaitIndicator release];
    [super dealloc];
}

@end
