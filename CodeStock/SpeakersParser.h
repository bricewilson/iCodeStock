//
//  SpeakersParser.h
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 TeamHealth. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Speaker;

@interface SpeakersParser : NSObject <NSXMLParserDelegate>
{
}

@property (nonatomic, retain) NSMutableString *currentXMLValue;
@property (nonatomic, retain) Speaker *currentSpeaker;
@property (nonatomic, retain) NSMutableArray *allSpeakers;

- (id) init;

@end
