//
//  Speaker.m
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import "Speaker.h"


@implementation Speaker

@synthesize bio;
@synthesize company;
@synthesize name;
@synthesize photoURL;
@synthesize speakerID;
@synthesize twitterID;
@synthesize website;

- (void) dealloc
{
    [bio release];
    [company release];
    [name release];
    [photoURL release];
    [speakerID release];
    [twitterID release];
    [website release];
    [super dealloc];
}

@end
