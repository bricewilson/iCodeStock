//
//  AllSessionsViewController.m
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import "SessionListViewController.h"
#import "Session.h"
#import "SessionViewController.h"
#import "CodeStockAppDelegate.h"
#import "Constants.h"


@implementation SessionListViewController

@synthesize allSessions;
@synthesize currentSession;
@synthesize currentXMLValue;
@synthesize sessionsTableView;
@synthesize groupTitle;

- (void) sessionsUpdated
{
	[self.navigationController popViewControllerAnimated:YES];
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
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier] autorelease];
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 2;
	}
    
	Session *cellSession = [self.allSessions objectAtIndex:indexPath.row];
	
	cell.textLabel.font = [UIFont systemFontOfSize:17.0];
	cell.textLabel.text = [NSString stringWithString:cellSession.title];
	cell.detailTextLabel.text = [NSString stringWithString:cellSession.technology];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 75;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section
{
    return [self.allSessions count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [NSString stringWithFormat:@"%@ Sessions", self.groupTitle];
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath 
{
    Session *cellSession = [self.allSessions objectAtIndex:indexPath.row];
    SessionViewController *sessionVC = [[SessionViewController alloc] initWithNibName:@"SessionView" bundle:nil];
    sessionVC.currentSession = cellSession;
    [self.navigationController pushViewController:sessionVC animated:YES];
    [sessionVC release];
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	return [NSString stringWithFormat:@"%@ Sessions", self.groupTitle];
}


#pragma mark - View Management

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Sessions";
    
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionsUpdated)
                                                 name:SessionsUpdatedMessage 
                                               object:nil];

    [self.sessionsTableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [allSessions release];
    [currentSession release];
	[currentXMLValue release];
	[sessionsTableView release];
	[groupTitle release];
    [super dealloc];
}

@end
