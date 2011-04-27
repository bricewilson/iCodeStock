//
//  CategoriesViewController.m
//  CodeStock
//
//  Created by Brice Wilson on 4/14/11.
//  Copyright 2011 TeamHealth. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CodeStockAppDelegate.h"
#import "Session.h"
#import "Constants.h"
#import "SessionListViewController.h"


@implementation CategoriesViewController

@synthesize categoriesTableView;
@synthesize groupedSessions;
@synthesize allCategories;
@synthesize waitView;

- (void) sessionsUpdated
{
	//self.groupedSessions = [self groupSessionsByCategory];
	
	CodeStockAppDelegate *app = (CodeStockAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.groupedSessions = app.groupedSessions;
	self.allCategories = app.allCategories;
	
	[self.categoriesTableView reloadData];
	[self.waitView stopAnimating];
	[self.waitView setHidden:YES];
}

- (void) printCategories
{
	for (NSString *c in self.allCategories)
	{
		NSLog(@"Category:  %@", c);
	}
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
	{
        self.groupedSessions = [[NSDictionary alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UITableViewDataSource Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"cell";
	
	// try to get reusable cell
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	// create new cell if necessary
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
	}
    
	NSString *cellCategory = [self.allCategories objectAtIndex:indexPath.row];
	
	cell.textLabel.text = cellCategory;
	cell.textLabel.textAlignment = UITextAlignmentCenter;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section
{
    return [self.allCategories count];
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath 
{
    NSString *cellCategory = [self.allCategories objectAtIndex:indexPath.row];
    SessionListViewController *sessionsVC = [[SessionListViewController alloc] initWithNibName:@"SessionListView" bundle:nil];
    sessionsVC.allSessions = [self.groupedSessions objectForKey:cellCategory];
	sessionsVC.groupTitle = cellCategory;
    [self.navigationController pushViewController:sessionsVC animated:YES];
    [sessionsVC release];
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
	
//	self.title = CategoriesTitle;
	
	[self.waitView setHidden: NO];
    [self.waitView startAnimating];

	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionsUpdated)
                                                 name:SessionsUpdatedMessage 
                                               object:nil];

	// if the sessions have been downloaded and processed, then group them now
	CodeStockAppDelegate *app = (CodeStockAppDelegate *)[[UIApplication sharedApplication] delegate];
	//if (app.allSessions)
	if ([app.allCategories count] > 0)
	{
		self.groupedSessions = app.groupedSessions;
		self.allCategories = app.allCategories;
		[self.categoriesTableView reloadData];
		[self.waitView stopAnimating];
		[self.waitView setHidden:YES];
	}
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

@end
