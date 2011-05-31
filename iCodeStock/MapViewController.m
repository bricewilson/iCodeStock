//
//  MapViewController.m
//  CodeStock
//
//  Created by Brice Wilson on 4/24/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import "MapViewController.h"
#import "CodeStockAppDelegate.h"
#import "Location.h"
#import "Constants.h"


@implementation MapViewController

@synthesize mapView;
@synthesize allLocations;
@synthesize centerLocation;

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Map methods

- (void)dropMarkers
{
	for (int i = 0; i < self.allLocations.count; i++)
	{
		Location *loc = [self.allLocations objectAtIndex:i];
		[mapView addAnnotation:loc];
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	if (annotation==self.mapView.userLocation)
        return nil;
	
	NSString *annotationIdentifier = [NSString string];
	
	if ([((Location *)annotation).category isEqualToString:ConferenceSiteCategory])
	{
		annotationIdentifier = ((Location *)annotation).category;
	}
	else
	{
		annotationIdentifier = @"PointOfInterest";
	}
	
	MKAnnotationView* pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
	
	if (!pinView)
	{
		MKPinAnnotationView* customPinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation
																			  reuseIdentifier:annotationIdentifier] autorelease];

		if ([annotationIdentifier isEqualToString:ConferenceSiteCategory])
		{
			customPinView.pinColor = MKPinAnnotationColorRed;
		}
		else
		{
			customPinView.pinColor = MKPinAnnotationColorPurple;
		}

		customPinView.animatesDrop = YES;
		customPinView.canShowCallout = YES;
		
		return customPinView;
	}
	else
	{
		pinView.annotation = annotation;
	}

	return pinView;
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	CodeStockAppDelegate *app = (CodeStockAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.allLocations = app.allLocations;
	
	// find the first "conference site" in the array of all locations
	NSUInteger index = [self.allLocations indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop)
						{
							return [((Location *)obj).category isEqualToString:ConferenceSiteCategory];
						}];
	
	self.centerLocation = [self.allLocations objectAtIndex:index];
	
	// center the map on the conference site obtained from the array
	MKCoordinateRegion newRegion;
	newRegion.center.latitude = self.centerLocation.latitude;
	newRegion.center.longitude = self.centerLocation.longitude;
	newRegion.span.latitudeDelta = .01;
	newRegion.span.longitudeDelta = .01;
	
    [self.mapView setRegion:newRegion animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	
	// drop the markers 1 second after the view appears
    [self performSelector:@selector(dropMarkers) withObject:nil afterDelay:1.0f];
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

- (void)dealloc
{
	[mapView release];
	[allLocations release];
	[centerLocation release];
    [super dealloc];
}

@end
