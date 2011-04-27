//
//  AllSessionsViewController.h
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 TeamHealth. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Session;


@interface SessionListViewController : UIViewController <UITableViewDataSource>
{
}

@property (nonatomic, retain) NSArray *allSessions;
@property (nonatomic, retain) Session *currentSession;
@property (nonatomic, retain) NSMutableString *currentXMLValue;
@property (nonatomic, retain) IBOutlet UITableView *sessionsTableView;
@property (nonatomic, retain) NSString *groupTitle;

- (void) sessionsUpdated;

@end
