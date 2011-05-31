//
//  Location.m
//  CodeStock
//
//  Created by Brice Wilson on 4/24/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import "Location.h"


@implementation Location

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize category;
@synthesize latitude;
@synthesize longitude;

-(id)initWithTitle:(NSString *)pTitle
			 subtitle:(NSString *)pSubtitle 
		category:(NSString *)pCategory 
			 latitude:(CLLocationDegrees)pLatitude 
			longitude:(CLLocationDegrees)pLongitude
{
	self.title = pTitle;
	self.subtitle = pSubtitle;
	self.category = pCategory;
	self.latitude = pLatitude;
	self.longitude = pLongitude;
	return self;
}

-(void)moveAnnotation:(CLLocationCoordinate2D)newCoordinate
{
	coordinate = newCoordinate;
}

-(CLLocationCoordinate2D)coordinate
{
	CLLocationCoordinate2D c;
	c.latitude = self.latitude;
	c.longitude = self.longitude;
	return c;
}

-(void)dealloc
{
    [title release];
    [subtitle release];
    [category release];
	[super dealloc];
}

@end
