//
//  SpeakersParser.m
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import "SpeakersParser.h"
#import "Speaker.h"
#import "CodeStockAppDelegate.h"


@implementation SpeakersParser

@synthesize currentSpeaker;
@synthesize allSpeakers;

- (id) init
{
	self.allSpeakers = [NSMutableArray arrayWithCapacity:0];
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

    if ([elementName isEqualToString:@"CodeStockSpeaker"])
    {
		Speaker *newSpeaker = [[Speaker alloc] init];
		self.currentSpeaker = newSpeaker;
		[newSpeaker release];
    }
}

// This method gets called for every character NSXMLParser finds.
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [currentXMLValue appendString:string];
}

// This method is called whenever NSXMLParser reaches the end of an element
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Bio"])
    {
        self.currentSpeaker.bio = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"Company"])
    {
        self.currentSpeaker.company = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"Name"])
    {
        self.currentSpeaker.name = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"PhotoUrl"])
    {
        self.currentSpeaker.photoURL = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"SpeakerID"])
    {
        self.currentSpeaker.speakerID = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"TwitterID"])
    {
        self.currentSpeaker.twitterID = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"Website"])
    {
        self.currentSpeaker.website = [currentXMLValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    if ([elementName isEqualToString:@"CodeStockSpeaker"])
    {
        [self.allSpeakers addObject:self.currentSpeaker];
        
        [currentSpeaker release];
        currentSpeaker = nil;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    CodeStockAppDelegate *app = (CodeStockAppDelegate *)[[UIApplication sharedApplication] delegate];
    app.allSpeakers = self.allSpeakers;
	
	[currentXMLValue release];
	currentXMLValue = nil;

}

- (void)dealloc
{
	[currentXMLValue release];
	[currentSpeaker release];
	[allSpeakers release];
	[super dealloc];
}

@end
