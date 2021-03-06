//
//  CodeStockAppDelegate.h
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;

@interface CodeStockAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {

	NSArray *allSessions;
	NSArray *allSpeakers;
	NSArray *allLocations;
	Reachability *internetReach;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSDictionary *groupedSessions;
@property (nonatomic, retain) NSArray *allCategories;
@property (nonatomic, assign) BOOL appLoading;
@property (nonatomic, retain) NSArray *allSpeakers;
@property (nonatomic, retain) NSArray *allLocations;

- (void) parseXMLFromURL:(NSString *)urlString parser:(id<NSXMLParserDelegate>)xmlParser;
- (void) loadData;
- (void) setAllSessions:(NSArray *)sessions;
- (NSArray *) allSessions;
- (void) sendNewSessionsNotification;
- (void) updateInterfaceWithReachability: (Reachability *)curReach;
- (void) reachabilityChanged: (NSNotification* )note;
- (NSDictionary *) groupSessionsByCategory;
-(NSInvocation *)invocationParserForURL:(NSString *)urlString parser:(id<NSXMLParserDelegate>)xmlParser;

- (void) printSpeakers;
- (void) printSessions;
- (void) printLocations;
- (void) printCategoriesAndSessions;

@end
