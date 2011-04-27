//
//  CategoriesViewController.h
//  CodeStock
//
//  Created by Brice Wilson on 4/14/11.
//  Copyright 2011 TeamHealth. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CategoriesViewController : UIViewController <UITableViewDataSource>
{
}

@property (nonatomic, retain) IBOutlet UITableView *categoriesTableView;
@property (nonatomic, retain) NSDictionary *groupedSessions;
@property (nonatomic, retain) NSArray *allCategories;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *waitView;


//- (NSDictionary *) groupSessionsByCategory;
- (void) sessionsUpdated;
- (void) printCategories;

@end
