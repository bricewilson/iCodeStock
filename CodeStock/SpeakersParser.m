//
//  SpeakersParser.m
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 TeamHealth. All rights reserved.
//

#import "SpeakersParser.h"
#import "Speaker.h"
#import "CodeStockAppDelegate.h"


@implementation SpeakersParser

@synthesize currentXMLValue;
@synthesize currentSpeaker;
@synthesize allSpeakers;

- (id) init
{
	self.allSpeakers = [NSMutableArray arrayWithCapacity:0];
	return self;
}

#pragma mark - XML Parser

// This method gets called every time NSXMLParser encounters a new element
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qualifiedName
   attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"CodeStockSpeaker"])
    {
		self.currentSpeaker = [[Speaker alloc] init];
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
    if ([elementName isEqualToString:@"Bio"])
    {
        self.currentSpeaker.bio = [self.currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"Company"])
    {
        self.currentSpeaker.company = [self.currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"Name"])
    {
        self.currentSpeaker.name = [self.currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"PhotoUrl"])
    {
        self.currentSpeaker.photoURL = [self.currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"SpeakerID"])
    {
        self.currentSpeaker.speakerID = [self.currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"TwitterID"])
    {
        self.currentSpeaker.twitterID = [self.currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"Website"])
    {
        self.currentSpeaker.website = [self.currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"CodeStockSpeaker"])
    {
        [self.allSpeakers addObject:self.currentSpeaker];
        
        [currentSpeaker release];
        currentSpeaker = nil;
    }
	
	[currentXMLValue release];
	currentXMLValue = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    CodeStockAppDelegate *app = (CodeStockAppDelegate *)[[UIApplication sharedApplication] delegate];
    app.allSpeakers = self.allSpeakers;
}

@end
