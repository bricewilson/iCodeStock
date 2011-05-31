//
//  SecondViewController.h
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StartTimesViewController : UIViewController
{
}

@property (nonatomic, retain) IBOutlet UITableView *dateTimeTableView;
@property (nonatomic, retain) NSDictionary *groupedSessions;
@property (nonatomic, retain) NSArray *allDates;
@property (nonatomic, retain) NSArray *tableSections;

- (NSDictionary *) groupSessionsByDateTime;
- (void) sessionsUpdated;
- (void) printDateTimeAndSessions;

@end
