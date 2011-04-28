//
//  LocationsParser.m
//  CodeStock
//
//  Created by Brice Wilson on 4/24/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import "LocationsParser.h"
#import "Location.h"
#import "CodeStockAppDelegate.h"


@implementation LocationsParser

@synthesize currentLocation;
@synthesize allLocations;

- (id) init
{
	self.allLocations = [NSMutableArray arrayWithCapacity:0];
	return self;
}

#pragma mark - XML Parser

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
	currentXMLValue = [[NSMutableString alloc] init];
}

// This method gets called every time NSXMLParser encounters a new element
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
    
	[currentXMLValue setString:@""];

    if ([elementName isEqualToString:@"CodeStockLocation"])
    {
		self.currentLocation = [[Location alloc] init];
    }
}

// This method gets called for every character NSXMLParser finds.
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [currentXMLValue appendString:string];
}

// This method is called whenever NSXMLParser reaches the end of an element
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Title"])
    {
        self.currentLocation.title = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"Subtitle"])
    {
        self.currentLocation.subtitle = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"Category"])
    {
        self.currentLocation.category = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"Latitude"])
    {
        self.currentLocation.latitude = [[currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] doubleValue];
    }
    if ([elementName isEqualToString:@"Longitude"])
    {
        self.currentLocation.longitude = [[currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] doubleValue];
    }
    if ([elementName isEqualToString:@"CodeStockLocation"])
    {
        [self.allLocations addObject:self.currentLocation];
        
        [currentLocation release];
        currentLocation = nil;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    CodeStockAppDelegate *app = (CodeStockAppDelegate *)[[UIApplication sharedApplication] delegate];
    app.allLocations = self.allLocations;
	
	[currentXMLValue release];
	currentXMLValue = nil;
}

- (void)dealloc
{
	[currentXMLValue release];
	[currentLocation release];
	[allLocations release];
	[super dealloc];
}

@end
