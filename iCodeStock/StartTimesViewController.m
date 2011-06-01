//
//  SecondViewController.m
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import "StartTimesViewController.h"
#import "Constants.h"
#import "CodeStockAppDelegate.h"
#import "Session.h"
#import "SessionListViewController.h"
#import "OrderedDictionary.h"


@implementation StartTimesViewController

@synthesize dateTimeTableView;
@synthesize groupedSessions;
@synthesize allDates;
@synthesize tableSections;

- (void) sessionsUpdated
{
	self.groupedSessions = [self groupSessionsByDateTime];
	[self.dateTimeTableView reloadData];
}

- (NSDictionary *) groupSessionsByDateTime
{
	CodeStockAppDelegate *app = (CodeStockAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	// sort the array
	NSSortDescriptor *sortDescriptor;
	sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"startDateTime"
												  ascending:YES] autorelease];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	NSArray *sortedArray = [app.allSessions sortedArrayUsingDescriptors:sortDescriptors];

	NSMutableArray *dates = [NSMutableArray arrayWithCapacity:0];
	for (Session *s in sortedArray)
	{
		if (![dates containsObject:s.startDateFormatted])
		{
			[dates addObject:s.startDateFormatted];
		}
	}
	
	self.allDates = dates;

	// make an array of dictionaries to be used as the values in the grouped by date dictionary
	NSMutableArray *valueArray = [NSMutableArray arrayWithCapacity:0];
	for (int i = 0; i < [self.allDates count]; i++)
	{
		[valueArray addObject:[OrderedDictionary dictionary]];
	}
	
	// create a dictionary where each date is a key
	OrderedDictionary *dateDict = [OrderedDictionary dictionaryWithObjects:valueArray forKeys:self.allDates];

	for (Session *s in sortedArray)
	{
		OrderedDictionary *timeDictionary = [dateDict objectForKey:s.startDateFormatted];
		
		// create a new dictionary entry for the current session time if it doesn't already exist
		if (![timeDictionary objectForKey:s.startTimeFormatted])
		{
			[timeDictionary setObject:[NSMutableArray arrayWithCapacity:0] forKey:s.startTimeFormatted];
		}
		
		// add the session to the array of sessions for the current session's time
		NSMutableArray *sessions = [timeDictionary objectForKey:s.startTimeFormatted];
		[sessions addObject:s];
	}

	return dateDict;
}

- (void) printDateTimeAndSessions
{
	// print dates, times, and sessions
	for (NSString *d in self.groupedSessions)
	{
		NSLog(@"Date: %@", d);
		OrderedDictionary *timeDictionary = [self.groupedSessions objectForKey:d];
		for (NSString *t in timeDictionary)
		{
			NSLog(@"Time: %@", t);
			NSMutableArray *sessions = [timeDictionary objectForKey:t];
			for (Session *s in sessions)
			{
				NSLog(@"Title: %@", s.title);
			}
		}
	}	
}

#pragma mark - TableView delegate methods

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
	
	NSString *selectedDate = [self.allDates objectAtIndex:indexPath.section];
	OrderedDictionary *timeDictionary = [self.groupedSessions objectForKey:selectedDate];
	NSString *selectedTime = [timeDictionary keyAtIndex:indexPath.row];

	cell.textLabel.text = selectedTime;
	cell.textLabel.textAlignment = UITextAlignmentCenter;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.allDates count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section
{
	NSString *selectedDate = [self.allDates objectAtIndex:section];
	NSMutableDictionary *timeDictionary = [self.groupedSessions objectForKey:selectedDate];
	NSArray *allTimes = [timeDictionary allKeys];
	return [allTimes count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *selectedDate = [self.allDates objectAtIndex:section];
	return selectedDate;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath 
{
	NSString *selectedDate = [self.allDates objectAtIndex:indexPath.section];
	NSMutableDictionary *timeDictionary = [self.groupedSessions objectForKey:selectedDate];
	NSArray *allTimes = [timeDictionary allKeys];
	NSString *selectedTime = [allTimes objectAtIndex:indexPath.row];
	NSMutableArray *sessions = [timeDictionary objectForKey:selectedTime];
	
    SessionListViewController *sessionsVC = [[SessionListViewController alloc] initWithNibName:@"SessionListView" bundle:nil];
    sessionsVC.allSessions = sessions;
	sessionsVC.groupTitle = selectedTime;
    [self.navigationController pushViewController:sessionsVC animated:YES];
    [sessionsVC release];
}

//-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//	return @"Session Times Footer";
//}


#pragma mark - View management methods

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.tableSections = [self.groupedSessions allKeys];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionsUpdated)
                                                 name:SessionsUpdatedMessage 
                                               object:nil];
	
	// if the sessions have been downloaded and processed, then group them now
	CodeStockAppDelegate *app = (CodeStockAppDelegate *)[[UIApplication sharedApplication] delegate];
	if (app.allSessions)
	{
		self.groupedSessions = [self groupSessionsByDateTime];
		[self.dateTimeTableView reloadData];
		//[self printDateTimeAndSessions];
	}

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
	self.dateTimeTableView = nil;
    [super viewDidUnload];
}


- (void)dealloc
{
	[dateTimeTableView release];
	[groupedSessions release];
	[allDates release];
	[tableSections release];
    [super dealloc];
}

@end
