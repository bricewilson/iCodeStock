//
//  CodeStockAppDelegate.m
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import "CodeStockAppDelegate.h"
#import "SpeakersParser.h"
#import "Speaker.h"
#import "Session.h"
#import "SessionsParser.h"
#import "Constants.h"
#import "Reachability.h"
#import "LocationsParser.h"
#import "Location.h"

@implementation CodeStockAppDelegate

@synthesize window=_window;
@synthesize tabBarController=_tabBarController;
@synthesize groupedSessions;
@synthesize allCategories;
@synthesize appLoading;
@synthesize allSpeakers;
@synthesize allLocations;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.appLoading = YES;
	
	self.groupedSessions = [[NSDictionary alloc] init];

	[self loadData];

    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
	
	// Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
    // method "reachabilityChanged" will be called. 
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    internetReach = [[Reachability reachabilityForInternetConnection] retain];
	[internetReach startNotifier];
	[self updateInterfaceWithReachability: internetReach];
    
	[NSThread sleepForTimeInterval:2.0];

	self.appLoading = NO;
		
    return YES;
}

#pragma mark - Load data methods

- (void) loadData
{
	// load the data asychronously
    NSOperationQueue *queue = [NSOperationQueue new];
	
	// load sessions
	NSString *sessionsURL = [NSString stringWithString:SessionsURL];
	SessionsParser *sessionsParser = [[SessionsParser alloc] init];
	NSInvocation *sessionsInvocation = [self invocationParserForURL:sessionsURL parser:sessionsParser];
	NSInvocationOperation *sessionsOperation = [[NSInvocationOperation alloc] initWithInvocation:sessionsInvocation];
    [queue addOperation:sessionsOperation];
	[sessionsParser release];
    [sessionsOperation release];
	
	// load speakers
	NSString *speakersURL = [NSString stringWithString:SpeakersURL];
	SpeakersParser *speakersParser = [[SpeakersParser alloc] init];
	NSInvocation *speakerInvocation = [self invocationParserForURL:speakersURL parser:speakersParser];
	NSInvocationOperation *speakersOperation = [[NSInvocationOperation alloc] initWithInvocation:speakerInvocation];
    [queue addOperation:speakersOperation];
	[speakersParser release];
    [speakersOperation release];
	
	// load locations
	NSString *locationsURL = [NSString stringWithString:LocationsURL];
	LocationsParser *locationsParser = [[LocationsParser alloc] init];
	NSInvocation *locationInvocation = [self invocationParserForURL:locationsURL parser:locationsParser];
	NSInvocationOperation *locationsOperation = [[NSInvocationOperation alloc] initWithInvocation:locationInvocation];
	[queue addOperation:locationsOperation];
	[locationsParser release];
	[locationsOperation release];
	
	[queue release];
	
}

-(NSInvocation *)invocationParserForURL:(NSString *)urlString parser:(id<NSXMLParserDelegate>)xmlParser {

	// configure selector and signature used for invocation objects
	SEL parserSelector = @selector(parseXMLFromURL:parser:);
	NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:parserSelector];
	
	// create invocation object with specific parameters
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
	[invocation setTarget:self];
	[invocation setSelector:parserSelector];
	[invocation setArgument:&urlString atIndex:2];
	[invocation setArgument:&xmlParser atIndex:3];
	[invocation retainArguments];
	return invocation;
}

- (void) parseXMLFromURL:(NSString *)urlString parser:(id<NSXMLParserDelegate>)xmlParser
{
    NSURL *url = [[NSURL alloc] initWithString:urlString];	
	NSData *data = [[NSData alloc] initWithContentsOfURL:url];	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	
    // Tell NSXMLParser who it's delegate is
    [parser setDelegate:xmlParser];
	
    // Kick off file parsing
    [parser parse];
	
	[url release];
	[data release];
	[parser release];
}

- (NSDictionary *) groupSessionsByCategory
{
	NSMutableArray *categories = [NSMutableArray arrayWithCapacity:0];
	for (Session *s in self.allSessions)
	{
		if (![categories containsObject:s.area])
		{
			[categories addObject:s.area];
		}
	}
	
	self.allCategories = [categories sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	
	// make an array of arrays to be used as the values in the grouped dictionary
	NSMutableArray *valueArray = [NSMutableArray arrayWithCapacity:0];
	for (int i = 0; i < [self.allCategories count]; i++)
	{
		[valueArray addObject:[NSMutableArray arrayWithCapacity:0]];
	}
	
	NSDictionary *sessionDict = [NSDictionary dictionaryWithObjects:valueArray forKeys:self.allCategories];
	
	for (Session *s in self.allSessions)
	{
		NSMutableArray *categorySessions = [sessionDict objectForKey:s.area];
		[categorySessions addObject:s];
	}
		
	return sessionDict;
}

#pragma mark - Print methods

- (void) printSpeakers
{
    for (Speaker *s in self.allSpeakers)
    {
        NSLog(@"Speaker Name: %@", s.name);
    }
}

- (void) printLocations
{
	for (Location *loc in self.allLocations)
    {
        NSLog(@"Location Title: %@", loc.title);
		NSLog(@"Location Subtitle: %@", loc.subtitle);
		NSLog(@"Location Category: %@", loc.category);
		NSLog(@"Location Latitude: %@", [NSString stringWithFormat:@"%f", loc.latitude]);
		NSLog(@"Location Longitude: %@", [NSString stringWithFormat:@"%f", loc.longitude]);
	}
}

- (void) printSessions
{
    for (Session *s in self.allSessions)
    {
        NSLog(@"Session Title: %@", s.title);
		NSLog(@"Date: %@", s.startDateFormatted);
		NSLog(@"Time: %@", s.startTimeFormatted);
		
		// print the start date
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"MM/dd/yyyy"];
		[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
		NSString *outputDate = [dateFormatter stringFromDate:s.startDateTime];
		NSLog(@"Start Date: %@", outputDate);
		[dateFormatter release];
		
		// print the start time
		NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
		[timeFormatter setDateFormat:@"h:mm a"];
		[timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
		NSString *outputTime = [timeFormatter stringFromDate:s.startDateTime];
		NSLog(@"Start Time: %@", outputTime);
		[timeFormatter release];
    }
}

- (void) printCategoriesAndSessions
{
	// print categories and sessions
	for (NSString *s in self.allCategories)
	{
		NSLog(@"Category Name: %@", s);
		NSMutableArray *categorySessions = [self.groupedSessions objectForKey:s];
		for (Session *session in categorySessions)
		{
			NSLog(@"Session Title: %@", session.title);
		}
	}
}

#pragma mark - Session methods

- (void) sendNewSessionsNotification
{
	[[NSNotificationCenter defaultCenter] postNotificationName:SessionsUpdatedMessage object:self];
}

- (void) setAllSessions:(NSArray *)sessions
{
	NSArray* oldSessions = allSessions;
	allSessions = [sessions retain];
	[oldSessions release];
	
	self.groupedSessions = [self groupSessionsByCategory];
	
	// [self printCategoriesAndSessions];
	
	[self performSelectorOnMainThread:@selector(sendNewSessionsNotification) withObject:nil waitUntilDone:NO];
}

- (NSArray *) allSessions
{
	return allSessions;
}

#pragma mark - Reachability methods

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability: curReach];
}

- (void) updateInterfaceWithReachability: (Reachability *)curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    if (netStatus == NotReachable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Status"
                                                        message:@"Your network connection is unavailable. Please reconnect to continue using the application."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
	else if (self.appLoading == NO)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:DataRefreshMessage object:self];
		[self loadData];
	}
}


#pragma mark - Application lifecycle methods

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
	[[NSNotificationCenter defaultCenter] postNotificationName:DataRefreshMessage object:self];
	[self loadData];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
	[allSessions release];
	[allSpeakers release];
	[allLocations release];
	[groupedSessions release];
	[allCategories release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
