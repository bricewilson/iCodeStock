//
//  SessionsParser.m
//  CodeStock
//
//  Created by Brice Wilson on 4/14/11.
//  Copyright 2011 TeamHealth. All rights reserved.
//

#import "SessionsParser.h"
#import "Session.h"
#import "CodeStockAppDelegate.h"


@implementation SessionsParser

@synthesize currentXMLValue;
@synthesize currentSession;
@synthesize allSessions;


- (id) init
{
	self.allSessions = [NSMutableArray arrayWithCapacity:0];
	return self;
}

#pragma mark - XML Parser

// This method gets called every time NSXMLParser encounters a new element
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
	
    if ([elementName isEqualToString:@"CodeStockSession"])
    {
		self.currentSession = [[Session alloc] init];
    }
}

// This method gets called for every character NSXMLParser finds.
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    // If currentXMLValue doesn't exist, initialize and allocate
    if (!self.currentXMLValue)
    {
		self.currentXMLValue = [[NSMutableString alloc] init];
    }
    
    // Append the current character value to the running string
    // that is being parsed
    [self.currentXMLValue appendString:string];
}

// This method is called whenever NSXMLParser reaches the end of an element
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Abstract"])
    {
        self.currentSession.sessionAbstract = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"Area"])
    {
        self.currentSession.area = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"EndTime"])
    {
        self.currentSession.endTime = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
		// parse as date
		NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
		[inputDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
		[inputDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
		NSDate *sessionEnd = [inputDateFormatter dateFromString:self.currentSession.endTime];
		self.currentSession.endDateTime = sessionEnd;
		[inputDateFormatter release];
		
		// store formatted start date string
		NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
		[outputDateFormatter setDateFormat:@"MM/dd/yyyy"];
		[outputDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
		self.currentSession.endDateFormatted = [outputDateFormatter stringFromDate:self.currentSession.endDateTime];
		[outputDateFormatter release];
		
		// store formatted start time string
		NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
		[timeFormatter setDateFormat:@"h:mm a"];
		[timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
		self.currentSession.endTimeFormatted = [timeFormatter stringFromDate:self.currentSession.endDateTime];
		[timeFormatter release];

    }
    if ([elementName isEqualToString:@"LevelGeneral"])
    {
        self.currentSession.levelGeneral = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"LevelSpecific"])
    {
        self.currentSession.levelSpecific = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"Room"])
    {
        self.currentSession.room = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"SessionID"])
    {
        self.currentSession.sessionID = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"SpeakerID"])
    {
        self.currentSession.speakerID = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"StartTime"])
    {
		// parse as string
        self.currentSession.startTime = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		
		// parse as date
		NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
		[inputDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
		[inputDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
		NSDate *sessionStart = [inputDateFormatter dateFromString:self.currentSession.startTime];
		self.currentSession.startDateTime = sessionStart;
		[inputDateFormatter release];
		
		// store formatted start date string
		NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
		[outputDateFormatter setDateFormat:@"EEEE - MM/dd/yyyy"];
		[outputDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
		self.currentSession.startDateFormatted = [outputDateFormatter stringFromDate:self.currentSession.startDateTime];
		[outputDateFormatter release];
		
		// store formatted start time string
		NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
		[timeFormatter setDateFormat:@"h:mm a"];
		[timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
		self.currentSession.startTimeFormatted = [timeFormatter stringFromDate:self.currentSession.startDateTime];
		[timeFormatter release];

    }
    if ([elementName isEqualToString:@"Technology"])
    {
        self.currentSession.technology = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"Title"])
    {
        self.currentSession.title = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"Track"])
    {
        self.currentSession.track = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"CodeStockSession"])
    {
        [self.allSessions addObject:self.currentSession];
        
        [currentSession release];
        currentSession = nil;
    }
	
	[currentXMLValue release];
	currentXMLValue = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    CodeStockAppDelegate *app = (CodeStockAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	// sort the array
	NSSortDescriptor *sortDescriptor;
	sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"title"
												  ascending:YES
					   selector:@selector(caseInsensitiveCompare:)] autorelease];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	NSArray *sortedArray;
	sortedArray = [self.allSessions sortedArrayUsingDescriptors:sortDescriptors];
	
    app.allSessions = sortedArray;
}

@end
