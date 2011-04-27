//
//  CategoriesViewController.h
//  CodeStock
//
//  Created by Brice Wilson on 4/14/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CategoriesViewController : UIViewController <UITableViewDataSource>
{
}

@property (nonatomic, retain) IBOutlet UITableView *categoriesTableView;
@property (nonatomic, retain) NSDictionary *groupedSessions;
@property (nonatomic, retain) NSArray *allCategories;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *waitView;

- (void) sessionsUpdated;
- (void) printCategories;

@end
