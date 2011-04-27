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

- (void) parseSpeakers;
- (void) printSpeakers;

- (void) parseSessions;
- (void) printSessions;

- (void) parseLocations;
- (void) printLocations;

- (void) printCategoriesAndSessions;

- (void) loadData;

- (void) setAllSessions:(NSArray *)sessions;
- (NSArray *) allSessions;
- (void) sendNewSessionsNotification;

- (void) setAllSpeakers:(NSArray *)speakers;
- (NSArray *) allSpeakers;
- (void) sendNewSpeakersNotification;

- (void) setAllLocations:(NSArray *)locations;
- (NSArray *) allLocations;
- (void) sendNewLocationsNotification;

- (void) updateInterfaceWithReachability: (Reachability *)curReach;
- (void) reachabilityChanged: (NSNotification* )note;

- (NSDictionary *) groupSessionsByCategory;


@end
