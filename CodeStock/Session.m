//
//  Session.m
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 TeamHealth. All rights reserved.
//

#import "Session.h"


@implementation Session

@synthesize sessionAbstract;
@synthesize area;
@synthesize endTime;
@synthesize levelGeneral;
@synthesize levelSpecific;
@synthesize room;
@synthesize sessionID;
@synthesize speakerID;
@synthesize startTime;
@synthesize technology;
@synthesize title;
@synthesize track;
@synthesize startDateTime;
@synthesize endDateTime;
@synthesize startTimeFormatted;
@synthesize endTimeFormatted;
@synthesize startDateFormatted;
@synthesize endDateFormatted;

-(void)dealloc
{
    [sessionAbstract release];
    [area release];
    [endTime release];
    [levelGeneral release];
    [levelSpecific release];
    [room release];
    [sessionID release];
    [speakerID release];
    [startTime release];
    [technology release];
    [title release];
    [track release];
    
    [super dealloc];
}

@end
